set(atomic_srcs
        ${BOOST_SOURCE}/libs/atomic/src/lock_pool.cpp
        ${BOOST_SOURCE}/libs/atomic/src/find_address_sse2.cpp)

if (WIN32)
  set(atomic_libs ${atomic_srcs}
          ${BOOST_SOURCE}/libs/atomic/src/wait_ops_windows.cpp)
endif()

_add_boost_lib(
  NAME atomic
  SOURCES
    ${atomic_srcs}
  INCLUDE_PRIVATE
    ${BOOST_SOURCE}/libs/atomic/src
  DEFINE_PRIVATE
    BOOST_ATOMIC_STATIC_LINK=1
    BOOST_ATOMIC_SOURCE
)

_add_boost_test(
  NAME atomic_test
  LINK
    Boost::atomic
    Boost::thread
  DEFINE
    # The tests expect APIs deprecated in Thread v4, so enable them
    BOOST_THREAD_PROVIDES_NESTED_LOCKS=1
    BOOST_THREAD_USES_DATETIME=1
  TESTS
    RUN ${BOOST_SOURCE}/libs/atomic/test/atomicity.cpp
    RUN ${BOOST_SOURCE}/libs/atomic/test/ordering.cpp
    RUN ${BOOST_SOURCE}/libs/atomic/test/lockfree.cpp
)
