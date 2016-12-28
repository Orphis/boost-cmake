_add_boost_lib(
  NAME fiber
  SOURCES
    ${BOOST_SOURCE}/libs/fiber/src/
    ${BOOST_SOURCE}/libs/fiber/src/algo/algorithm.cpp
    ${BOOST_SOURCE}/libs/fiber/src/algo/round_robin.cpp
    ${BOOST_SOURCE}/libs/fiber/src/algo/shared_work.cpp
    ${BOOST_SOURCE}/libs/fiber/src/algo/work_stealing.cpp
    ${BOOST_SOURCE}/libs/fiber/src/barrier.cpp
    ${BOOST_SOURCE}/libs/fiber/src/condition_variable.cpp
    ${BOOST_SOURCE}/libs/fiber/src/context.cpp
    ${BOOST_SOURCE}/libs/fiber/src/fiber.cpp
    ${BOOST_SOURCE}/libs/fiber/src/future.cpp
    ${BOOST_SOURCE}/libs/fiber/src/mutex.cpp
    ${BOOST_SOURCE}/libs/fiber/src/properties.cpp
    ${BOOST_SOURCE}/libs/fiber/src/recursive_mutex.cpp
    ${BOOST_SOURCE}/libs/fiber/src/recursive_timed_mutex.cpp
    ${BOOST_SOURCE}/libs/fiber/src/timed_mutex.cpp
    ${BOOST_SOURCE}/libs/fiber/src/scheduler.cpp
  DEFINE_PRIVATE
    BOOST_FIBERS_SOURCE=1
  LINK
    Boost::context
)
set_target_properties(Boost_fiber PROPERTIES
  CXX_STANDARD 11
  CXX_STANDARD_REQUIRED ON
)
