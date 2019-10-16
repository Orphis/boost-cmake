_add_boost_lib(
  NAME stacktrace
  SOURCES
    ${BOOST_SOURCE}/libs/stacktrace/src/addr2line.cpp
    ${BOOST_SOURCE}/libs/stacktrace/src/backtrace.cpp
    ${BOOST_SOURCE}/libs/stacktrace/src/basic.cpp
    ${BOOST_SOURCE}/libs/stacktrace/src/noop.cpp
    ${BOOST_SOURCE}/libs/stacktrace/src/windbg.cpp
    ${BOOST_SOURCE}/libs/stacktrace/src/windbg_cached.cpp
  DEFINE_PRIVATE
    BOOST_STACKTRACE_STATIC_LINK=1
)

_add_boost_test(
  NAME stacktrace_test
  LINK
    Boost::stacktrace
  TESTS
    RUN ${BOOST_SOURCE}/libs/stacktrace/test/test.cpp
    RUN ${BOOST_SOURCE}/libs/stacktrace/test/test_impl.cpp
    RUN ${BOOST_SOURCE}/libs/stacktrace/test/test_noop.cpp
    RUN ${BOOST_SOURCE}/libs/stacktrace/test/test_num_conv.cpp
    RUN ${BOOST_SOURCE}/libs/stacktrace/test/test_void_ptr_cast.cpp
)
