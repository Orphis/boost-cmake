if(USE_WINDOWS)
  set(coroutine_srcs
    ${BOOST_SOURCE}/libs/coroutine/src/windows/stack_traits.cpp
  )
else()
  set(coroutine_srcs
    ${BOOST_SOURCE}/libs/coroutine/src/posix/stack_traits.cpp
  )
endif()

_add_boost_lib(
  NAME coroutine
  SOURCES
    ${coroutine_srcs}
    ${BOOST_SOURCE}/libs/coroutine/src/detail/coroutine_context.cpp
    ${BOOST_SOURCE}/libs/coroutine/src/exceptions.cpp
  DEFINE_PRIVATE
    BOOST_COROUTINES_SOURCE
  LINK
    Boost::context
    Boost::system
    Boost::thread
)
