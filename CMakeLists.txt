cmake_minimum_required(VERSION 3.16...3.23)

project(Boost-CMake LANGUAGES C CXX VERSION 1.79.0)

option(BOOST_DISABLE_TESTS "Do not build test targets, even if building standalone" OFF)

if(EXISTS "$ENV{CPM_SOURCE_CACHE}/boost_1_79_0")
  set(FETCHCONTENT_SOURCE_DIR_BOOST "$ENV{CPM_SOURCE_CACHE}/boost_1_79_0" CACHE PATH "Boost source DIR")
  set(CPM_Boost_SOURCE ${FETCHCONTENT_SOURCE_DIR_BOOST} CACHE PATH "Manual override")
endif()

set(BOOST_URL "https://boostorg.jfrog.io/artifactory/main/release/1.79.0/source/boost_1_79_0.tar.bz2"
    CACHE STRING "Boost download URL"
)
set(BOOST_URL_SHA256 "475d589d51a7f8b3ba2ba4eda022b170e562ca3b760ee922c146b6c65856ef39"
    CACHE STRING "Boost download URL SHA256 checksum"
)

include(FetchContent)
FetchContent_Declare(Boost URL ${BOOST_URL} URL_HASH SHA256=${BOOST_URL_SHA256})

FetchContent_GetProperties(Boost)
if(NOT Boost_POPULATED)
  message(STATUS "Fetching Boost")
  FetchContent_Populate(Boost)
  message(STATUS "Fetching Boost - done")
  set(BOOST_SOURCE ${boost_SOURCE_DIR})
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules)
include(CheckBoostVersion)

message(STATUS "Boost found: ${BOOST_VERSION} ${BOOST_SOURCE}")

include(StandaloneBuild)
include(PlatformDetect)
include(AddBoostLib)
include(AddBoostTest)

# NOTE: Install the missing CMakeList.txt file, but it will not yet used! CK
#       If the tar achive contains one, it will not overridden.
configure_file(cmake/CMakeLists.txt.in ${BOOST_SOURCE}/CMakeLists.txt @ONLY)
configure_file(cmake/Modules/ccache.cmake ${BOOST_SOURCE}/tools/cmake/include/ccache.cmake COPYONLY)

set_property(GLOBAL PROPERTY USE_FOLDERS TRUE)

if(USE_ANDROID)
  # CMake 3.7.1 doesn't define the target triple for the ASM language,
  # resulting in all files compiled for the host architecture
  set(CMAKE_ASM_COMPILER_TARGET "${CMAKE_CXX_COMPILER_TARGET}")
endif()

set(BOOST_LIBS_REQUIRED # Header only libs
    header
)
set(BOOST_LIBS_OPTIONAL
    # Compiled libs
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
    graph_parallel
    iostreams
    json
    locale
    log
    math
    mpi
    program_options
    #python # complex module
    random
    regex
    serialization
    system
    test
    thread
    timer
    type_erasure
    wave
    CACHE STRING "Boost libs to be compiled"
)

foreach(lib ${BOOST_LIBS_REQUIRED})
  include("libs/${lib}.cmake")
endforeach()

foreach(lib ${BOOST_LIBS_OPTIONAL})
  # In case only a subset of modules is available (eg. after using bcp)
  if(EXISTS "${BOOST_SOURCE}/libs/${lib}")
    include("libs/${lib}.cmake")
  endif()
endforeach()

# TODO: Move those to option() calls in the right file
if(NOT BOOST_STANDALONE)
  find_package(Threads)

  # Compilation options required by all platforms
  target_compile_definitions(
    Boost::boost
    INTERFACE $<$<CONFIG:Release>:BOOST_DISABLE_ASSERT>
              BOOST_ASIO_NO_DEPRECATED
              BOOST_SYSTEM_NO_DEPRECATED
              BOOST_THREAD_VERSION=5
              BOOST_THREAD_USES_CHRONO
              BOOST_THREAD_PROVIDES_EXECUTORS
  )
  add_library(Boost::asio ALIAS Boost::boost)
  target_link_libraries(Boost::boost INTERFACE Threads::Threads)
endif()

if(USE_ANDROID)
  # Android doesn't support thread local storage through compiler intrinsics
  target_compile_definitions(Boost::boost INTERFACE BOOST_ASIO_DISABLE_THREAD_KEYWORD_EXTENSION)
endif()
