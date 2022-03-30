_add_boost_lib(
  NAME timer
  SOURCES
    ${boost_SOURCE_DIR}/libs/timer/src/auto_timers_construction.cpp
    ${boost_SOURCE_DIR}/libs/timer/src/cpu_timer.cpp
  DEFINE_PRIVATE
    BOOST_TIMER_STATIC_LINK=1
  LINK
    Boost::chrono
)
