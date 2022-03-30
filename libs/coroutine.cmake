if(USE_WINDOWS)
  set(coroutine_srcs
    ${boost_SOURCE_DIR}/libs/coroutine/src/windows/stack_traits.cpp
  )
else()
  set(coroutine_srcs
    ${boost_SOURCE_DIR}/libs/coroutine/src/posix/stack_traits.cpp
  )
endif()

_add_boost_lib(
  NAME coroutine
  SOURCES
    ${coroutine_srcs}
    ${boost_SOURCE_DIR}/libs/coroutine/src/detail/coroutine_context.cpp
    ${boost_SOURCE_DIR}/libs/coroutine/src/exceptions.cpp
  DEFINE_PRIVATE
    BOOST_COROUTINES_SOURCE
  LINK
    Boost::context
    Boost::thread
)

_add_boost_test(
  NAME coroutine_test
  LINK
    Boost::coroutine
    Boost::unit_test_framework
  TESTS
    RUN ${boost_SOURCE_DIR}/libs/coroutine/test/test_asymmetric_coroutine.cpp
    RUN ${boost_SOURCE_DIR}/libs/coroutine/test/test_symmetric_coroutine.cpp
)
