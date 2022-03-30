if(USE_WINDOWS)
  set(THREAD_SRCS
    ${boost_SOURCE_DIR}/libs/thread/src/win32/thread.cpp
    ${boost_SOURCE_DIR}/libs/thread/src/win32/tss_pe.cpp
  )
else()
  set(THREAD_SRCS
    ${boost_SOURCE_DIR}/libs/thread/src/pthread/thread.cpp
    ${boost_SOURCE_DIR}/libs/thread/src/pthread/once.cpp
  )
endif()

_add_boost_lib(
  NAME thread
  SOURCES
    ${THREAD_SRCS}
    ${boost_SOURCE_DIR}/libs/thread/src/future.cpp
  DEFINE_PRIVATE
    BOOST_THREAD_BUILD_LIB=1
  LINK
    Boost::chrono
)
if(NOT USE_WINDOWS)
  find_package(Threads REQUIRED)

  target_link_libraries(Boost_thread PUBLIC Threads::Threads)
  target_compile_definitions(Boost_thread PRIVATE
    BOOST_THREAD_POSIX
  )
endif()
