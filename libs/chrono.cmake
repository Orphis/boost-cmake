_add_boost_lib(
  NAME chrono
  SOURCES
    ${boost_SOURCE_DIR}/libs/chrono/src/chrono.cpp
    ${boost_SOURCE_DIR}/libs/chrono/src/process_cpu_clocks.cpp
    ${boost_SOURCE_DIR}/libs/chrono/src/thread_clock.cpp
  DEFINE_PRIVATE
    BOOST_CHRONO_STATIC_LINK=1
    BOOST_SYSTEM_NO_DEPRECATED
)
if(NOT USE_WINDOWS)
  find_package(Threads)
  target_link_libraries(Boost_chrono PRIVATE Threads::Threads)

  find_library(RT_LIBRARY
    NAMES rt
    DOC "rt library"
  )
  if(RT_LIBRARY)
    target_link_libraries(Boost_chrono PRIVATE ${RT_LIBRARY})
  endif()
endif()
