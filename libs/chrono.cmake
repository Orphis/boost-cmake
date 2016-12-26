_add_boost_lib(
  NAME chrono
  SOURCES
    ${BOOST_SOURCE}/libs/chrono/src/chrono.cpp
    ${BOOST_SOURCE}/libs/chrono/src/process_cpu_clocks.cpp
    ${BOOST_SOURCE}/libs/chrono/src/thread_clock.cpp
  DEFINE_PRIVATE
    BOOST_CHRONO_STATIC_LINK=1
    BOOST_SYSTEM_NO_DEPRECATED
)
if(USE_LINUX)
  target_link_libraries(boost_chrono PUBLIC
    -lrt
    -pthread
  )
endif()
