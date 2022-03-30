_add_boost_lib(
  NAME fiber
  SOURCES
    ${boost_SOURCE_DIR}/libs/fiber/src/
    ${boost_SOURCE_DIR}/libs/fiber/src/algo/algorithm.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/algo/round_robin.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/algo/shared_work.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/algo/work_stealing.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/barrier.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/condition_variable.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/context.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/fiber.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/future.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/mutex.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/properties.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/recursive_mutex.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/recursive_timed_mutex.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/timed_mutex.cpp
    ${boost_SOURCE_DIR}/libs/fiber/src/scheduler.cpp
  DEFINE_PRIVATE
    BOOST_FIBERS_SOURCE=1
  LINK
    Boost::context
)
set_target_properties(Boost_fiber PROPERTIES
  CXX_STANDARD 11
  CXX_STANDARD_REQUIRED ON
)

_add_boost_test(
  NAME fiber_test
  LINK
    Boost::fiber
    Boost::thread
    Boost::unit_test_framework
  TESTS
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_async_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_async_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_barrier_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_barrier_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_buffered_channel_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_buffered_channel_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_condition_mt_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_condition_mt_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_condition_variable_any_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_condition_variable_any_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_condition_variable_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_condition_variable_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_fiber_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_fiber_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_fss_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_fss_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_future_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_future_mt_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_future_mt_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_future_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_mutex_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_mutex_mt_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_mutex_mt_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_mutex_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_packaged_task_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_packaged_task_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_promise_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_promise_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_shared_future_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_shared_future_post.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_unbuffered_channel_dispatch.cpp
    RUN ${boost_SOURCE_DIR}/libs/fiber/test/test_unbuffered_channel_post.cpp
)
