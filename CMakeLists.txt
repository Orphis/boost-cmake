cmake_minimum_required(VERSION 3.0.0)
project(Boost-CMake)

option(BOOST_DOWNLOAD_TO_BINARY_DIR "Prefer downloading Boost to the binary directory instead of source directory" OFF)
set(BOOST_URL "http://downloads.sourceforge.net/project/boost/boost/1.63.0/boost_1_63_0.7z")
set(BOOST_URL_SHA256 "25db3956a8d58187ac7a0702cc917e9bab47ff90baafc35e4e789dca1ce5f423")

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL "${CMAKE_SOURCE_DIR}")
  message("-- Standalone mode detected")
  set(BOOST_STANDALONE ON)
endif()

if(BOOST_DOWNLOAD_TO_BINARY_DIR)
  set(DOWNLOAD_PREFIX "${CMAKE_CURRENT_BINARY_DIR}")
else()
  set(DOWNLOAD_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}")
endif()
set(DOWNLOAD_PATH "${DOWNLOAD_PREFIX}/boost.7z")
set(EXTRACT_PATH "${DOWNLOAD_PREFIX}/boost")

if(BOOST_SOURCE AND NOT EXISTS "${BOOST_SOURCE}/boost/version.hpp")
  message(FATAL_ERROR "Folder ${BOOST_SOURCE} points to an invalid Boost source folder")
endif()

if(BOOST_LOCAL_SHA256 AND NOT BOOST_LOCAL_SHA256 STREQUAL "${BOOST_URL_SHA256}")
  message("New Boost version detected, removing older one")
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

    message("-- Downloading Boost from ${BOOST_URL}")
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

  if(NOT IS_DIRECTORY "${EXTRACT_PATH}")
    message("-- Extracting Boost archive...")
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

message("-- Boost found: ${BOOST_VERSION} ${BOOST_SOURCE}")

# Basic platform detection
include(CheckPreprocessor.cmake)
check_preprocessor(USE_LINUX __linux__)
check_preprocessor(USE_WINDOWS _WIN32)
check_preprocessor(USE_APPLE __APPLE__)

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

set(BOOST_LIBS
  atomic
  chrono
  container
  context
  coroutine
  date_time
  exception
  #fiber # depends on context
  filesystem
  graph
  #graph_parallel # depends on mpi
  iostreams
  #locale # depends on ICU or other external libraries
  #log # a bit complex and some platform specific setup
  math
  #mpi # partial dependency on python
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

# Compilation options required by all platforms
set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS $<$<CONFIG:Release>:BOOST_DISABLE_ASSERT>)
set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_SYSTEM_NO_DEPRECATED)
set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_THREAD_VERSION=4)
set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_THREAD_USES_CHRONO)
set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_THREAD_PROVIDES_EXECUTORS)
set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_ALL_NO_LIB=1)

if(USE_ANDROID)
  # Android doesn't support thread local storage through compiler intrinsics
  set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_ASIO_DISABLE_THREAD_KEYWORD_EXTENSION)
endif()
