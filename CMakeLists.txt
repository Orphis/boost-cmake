cmake_minimum_required(VERSION 3.0.0)
project(Boost-CMake)

option(BOOST_DOWNLOAD_TO_BINARY_DIR "Prefer downloading Boost to the binary directory instead of source directory" OFF)
set(BOOST_URL "https://github.com/Orphis/boost-cmake/releases/download/v1.63.0%2B1/boost_1_63_0-1.tar.xz" CACHE STRING "Boost download URL")
set(BOOST_URL_SHA256 "bb03ac7d13d6bfae52ac13ceaf54d88aa0c4776611bf60a942947f46aedcdb1a" CACHE STRING "Boost download URL SHA256 checksum")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL "${CMAKE_SOURCE_DIR}")
  message(STATUS "-- Standalone mode detected")
  set(BOOST_STANDALONE ON)
  set(CMAKE_CXX_STANDARD 11)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
  set(CMAKE_CXX_EXTENSIONS OFF)
  enable_testing()

  include(ccache)
endif()

if(BOOST_DOWNLOAD_TO_BINARY_DIR)
  set(DOWNLOAD_PREFIX "${CMAKE_CURRENT_BINARY_DIR}")
else()
  set(DOWNLOAD_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}")
endif()

get_filename_component(BOOST_URL_FILENAME "${BOOST_URL}" NAME)
set(DOWNLOAD_PATH "${DOWNLOAD_PREFIX}/${BOOST_URL_FILENAME}")
set(EXTRACT_PATH "${DOWNLOAD_PREFIX}/boost")

if(BOOST_SOURCE AND NOT EXISTS "${BOOST_SOURCE}/boost/version.hpp")
  message(FATAL_ERROR "Folder ${BOOST_SOURCE} points to an invalid Boost source folder")
endif()

if(BOOST_LOCAL_SHA256 AND NOT BOOST_LOCAL_SHA256 STREQUAL "${BOOST_URL_SHA256}")
  message(STATUS "New Boost version detected, removing older one")
  file(REMOVE_RECURSE "${EXTRACT_PATH}")
  file(REMOVE "${DOWNLOAD_PATH}")
  unset(BOOST_LOCAL_SHA256 CACHE)
  unset(BOOST_SOURCE CACHE)
endif()

if(NOT BOOST_SOURCE OR NOT EXISTS "${BOOST_SOURCE}")
  # Check existing file
  if(EXISTS "${DOWNLOAD_PATH}")
    file(SHA256 "${DOWNLOAD_PATH}" LOCAL_SHA256)
    if(NOT LOCAL_SHA256 STREQUAL "${BOOST_URL_SHA256}")
      message(WARNING "File ${DOWNLOAD_PATH} doesn't match the expected SHA256.\n Local ${LOCAL_SHA256} != Expected ${BOOST_URL_SHA256}")
      file(REMOVE "${DOWNLOAD_PATH}")
    endif()
  endif()

  if(NOT EXISTS "${DOWNLOAD_PATH}")
    file(REMOVE "${DOWNLOAD_PATH}.tmp")

    message(STATUS "-- Downloading Boost from ${BOOST_URL}")
    file(DOWNLOAD ${BOOST_URL} "${DOWNLOAD_PATH}.tmp"
         EXPECTED_HASH SHA256=${BOOST_URL_SHA256}
         STATUS download_status
         LOG download_log
         SHOW_PROGRESS
    )
    list(GET download_status 0 download_status_code)
    list(GET download_status 1 download_status_message)
    if(download_status_code)
      file(REMOVE "${DOWNLOAD_PATH}.tmp")
      message(FATAL_ERROR "Download failed. Status: ${download_status_code} ${download_status_message}\nLog: ${download_log}")
    endif()
    file(RENAME "${DOWNLOAD_PATH}.tmp" "${DOWNLOAD_PATH}")
  endif()

  set(BOOST_LOCAL_SHA256 "${BOOST_URL_SHA256}" CACHE STRING "Current SHA256 of Boost archive used" FORCE)
  mark_as_advanced(BOOST_LOCAL_SHA256)

  if(NOT IS_DIRECTORY "${EXTRACT_PATH}")
    message(STATUS "-- Extracting Boost archive...")
    if(EXISTS "${EXTRACT_PATH}.tmp")
      file(REMOVE_RECURSE "${EXTRACT_PATH}.tmp")
    endif()
    file(MAKE_DIRECTORY "${EXTRACT_PATH}.tmp")
    execute_process(
      COMMAND ${CMAKE_COMMAND} -E tar xfv ${DOWNLOAD_PATH}
      WORKING_DIRECTORY "${EXTRACT_PATH}.tmp"
      OUTPUT_QUIET
    )
    file(RENAME "${EXTRACT_PATH}.tmp" "${EXTRACT_PATH}")
  endif()

  file(GLOB download_boost_root "${EXTRACT_PATH}/boost_*")
  if(download_boost_root)
    set(BOOST_SOURCE "${download_boost_root}" CACHE STRING "Boost location" FORCE)
  endif()
endif()

file(STRINGS "${BOOST_SOURCE}/boost/version.hpp" boost_version_raw
  REGEX "define BOOST_VERSION "
)
string(REGEX MATCH "[0-9]+" boost_version_raw "${boost_version_raw}")
math(EXPR BOOST_VERSION_MAJOR "${boost_version_raw} / 100000")
math(EXPR BOOST_VERSION_MINOR "${boost_version_raw} / 100 % 1000")
math(EXPR BOOST_VERSION_PATCH "${boost_version_raw} % 100")
set(BOOST_VERSION "${BOOST_VERSION_MAJOR}.${BOOST_VERSION_MINOR}.${BOOST_VERSION_PATCH}")

message(STATUS "-- Boost found: ${BOOST_VERSION} ${BOOST_SOURCE}")

# Basic platform detection
include(CheckPreprocessor)
check_preprocessor(USE_LINUX __linux__)
check_preprocessor(USE_WINDOWS _WIN32)
check_preprocessor(USE_APPLE __APPLE__)
check_preprocessor(USE_ANDROID __ANDROID__)
check_preprocessor(USE_FREEBSD __FreeBSD__)

if(USE_ANDROID)
  # CMake 3.7.1 doesn't define the target triple for the ASM language,
  # resulting in all files compiled for the host architecture
  set(CMAKE_ASM_COMPILER_TARGET "${CMAKE_CXX_COMPILER_TARGET}")
endif()

# Define the header-only Boost target
add_library(Boost::boost INTERFACE IMPORTED GLOBAL)
if(CMAKE_GENERATOR MATCHES "Xcode")
  # The CMake Xcode generator doesn't support system headers directly
  set_target_properties(Boost::boost PROPERTIES INTERFACE_COMPILE_OPTIONS "-isystem;${BOOST_SOURCE}")
else()
  set_target_properties(Boost::boost PROPERTIES INTERFACE_SYSTEM_INCLUDE_DIRECTORIES ${BOOST_SOURCE})
  set_target_properties(Boost::boost PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${BOOST_SOURCE})
endif()

function(_add_boost_lib)
  set(options )
  set(oneValueArgs NAME)
  set(multiValueArgs SOURCES LINK DEFINE DEFINE_PRIVATE CXXFLAGS_PRIVATE)
  cmake_parse_arguments(BOOSTLIB "${options}" "${oneValueArgs}"
                        "${multiValueArgs}" ${ARGN})
  add_library(Boost_${BOOSTLIB_NAME} STATIC ${BOOSTLIB_SOURCES})
  add_library(Boost::${BOOSTLIB_NAME} ALIAS Boost_${BOOSTLIB_NAME})
  set_target_properties(Boost_${BOOSTLIB_NAME} PROPERTIES OUTPUT_NAME "boost_${BOOSTLIB_NAME}")
  if(NOT BOOST_STANDALONE)
    set_target_properties(Boost_${BOOSTLIB_NAME} PROPERTIES EXCLUDE_FROM_ALL 1)
  endif()
  target_link_libraries(Boost_${BOOSTLIB_NAME} PUBLIC Boost::boost)
  if(MSVC)
    target_compile_options(Boost_${BOOSTLIB_NAME} PRIVATE /w)
  else()
    target_compile_options(Boost_${BOOSTLIB_NAME} PRIVATE -w)
  endif()
  if(BOOSTLIB_LINK)
    target_link_libraries(Boost_${BOOSTLIB_NAME} PUBLIC ${BOOSTLIB_LINK})
  endif()
  if(BOOSTLIB_DEFINE)
    target_compile_definitions(Boost_${BOOSTLIB_NAME} PUBLIC ${BOOSTLIB_DEFINE})
  endif()
  if(BOOSTLIB_DEFINE_PRIVATE)
    target_compile_definitions(Boost_${BOOSTLIB_NAME} PRIVATE ${BOOSTLIB_DEFINE_PRIVATE})
  endif()
  if(BOOSTLIB_CXXFLAGS_PRIVATE)
    target_compile_options(Boost_${BOOSTLIB_NAME} PRIVATE ${BOOSTLIB_CXXFLAGS_PRIVATE})
  endif()
endfunction()

function(_add_boost_test)
  if(NOT BOOST_STANDALONE)
    return()
  endif()

  set(options)
  set(oneValueArgs NAME)
  set(multiValueArgs LINK DEFINE TESTS)
  cmake_parse_arguments(BOOSTTEST "${options}" "${oneValueArgs}"
                        "${multiValueArgs}" ${ARGN})

  # Split all arguments for TESTS in groups
  list(LENGTH BOOSTTEST_TESTS arg_len)
  set(arg_start 0)
  while(${arg_start} LESS ${arg_len})
    list(GET BOOSTTEST_TESTS ${arg_start} test_command)
    math(EXPR arg_start "${arg_start} + 1")
    unset(test_files)

    foreach(arg_pos RANGE ${arg_start} ${arg_len})
      set(arg_start ${arg_pos})
      if(arg_start EQUAL ${arg_len})
        break()
      endif()

      list(GET BOOSTTEST_TESTS ${arg_pos} arg)
      if(arg STREQUAL "RUN")
        break()
      else()
        list(APPEND test_files ${arg})
      endif()
    endforeach()

    if(test_command STREQUAL "RUN")
      if(NOT test_files)
        message(FATAL_ERROR "Missing files for test command ${test_command}")
      endif()
      list(GET test_files 0 main_src)
      get_filename_component(source_name ${main_src} NAME_WE)
      set(test_name Boost_${BOOSTTEST_NAME}_${source_name})
      add_executable(${test_name} ${test_files})
      add_test(NAME ${test_name}
        COMMAND ${test_name}
        WORKING_DIRECTORY ${BOOST_SOURCE}/status
      )
      if(MSVC)
        target_compile_options(${test_name} PRIVATE /bigobj)
      endif()
      if(NOT BOOST_STANDALONE)
        set_target_properties(${test_name} PROPERTIES EXCLUDE_FROM_ALL 1)
      endif()
      if(BOOSTTEST_DEFINE)
        target_compile_definitions(${test_name} PUBLIC ${BOOSTTEST_DEFINE})
      endif()
      if(BOOSTTEST_LINK)
        target_link_libraries(${test_name} PUBLIC ${BOOSTTEST_LINK})
      endif()
    else()
      message(FATAL_ERROR "Unknown test command: ${test_command}")
    endif()
  endwhile()
endfunction()

set(BOOST_LIBS
  atomic
  chrono
  container
  context
  coroutine
  date_time
  exception
  fiber
  filesystem
  graph
  iostreams
  #locale # depends on ICU or other external libraries
  #log # a bit complex and some platform specific setup
  math
  mpi
  graph_parallel # depends on mpi, so needs to be put after it
  program_options
  #python # complex module
  random
  regex
  serialization
  signals
  system
  unit_test_framework
  thread
  timer
  type_erasure
  wave
)

foreach(lib ${BOOST_LIBS})
  include("libs/${lib}.cmake")
endforeach()

if(NOT BOOST_STANDALONE)
  # Compilation options required by all platforms
  set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS $<$<CONFIG:Release>:BOOST_DISABLE_ASSERT>)
  set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_SYSTEM_NO_DEPRECATED)
  set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_THREAD_VERSION=4)
  set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_THREAD_USES_CHRONO)
  set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_THREAD_PROVIDES_EXECUTORS)
endif()

# Disable autolink
set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_ALL_NO_LIB=1)

if(USE_ANDROID)
  # Android doesn't support thread local storage through compiler intrinsics
  set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_ASIO_DISABLE_THREAD_KEYWORD_EXTENSION)
endif()
