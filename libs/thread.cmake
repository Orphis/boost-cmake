if(USE_WINDOWS)
  set(THREAD_SRCS
    ${BOOST_SOURCE}/libs/thread/src/win32/thread.cpp
    ${BOOST_SOURCE}/libs/thread/src/win32/tss_pe.cpp
  )
else()
  set(THREAD_SRCS
    ${BOOST_SOURCE}/libs/thread/src/pthread/thread.cpp
    ${BOOST_SOURCE}/libs/thread/src/pthread/once.cpp
  )
endif()

_add_boost_lib(
  NAME thread
  SOURCES
    ${THREAD_SRCS}
    ${BOOST_SOURCE}/libs/thread/src/future.cpp
  DEFINE_PRIVATE
    BOOST_THREAD_BUILD_LIB=1
  LINK Boost::chrono
)
if(NOT USE_WINDOWS)
  target_compile_definitions(boost_thread PRIVATE
    BOOST_THREAD_POSIX
  )
endif()
if(USE_LINUX)
  target_link_libraries(boost_thread PUBLIC -pthread)
endif()
