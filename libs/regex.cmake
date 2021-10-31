_add_boost_lib(
  NAME regex
  SOURCES
    ${BOOST_SOURCE}/libs/regex/src/posix_api.cpp
    ${BOOST_SOURCE}/libs/regex/src/regex.cpp
    ${BOOST_SOURCE}/libs/regex/src/regex_debug.cpp
    ${BOOST_SOURCE}/libs/regex/src/static_mutex.cpp
    ${BOOST_SOURCE}/libs/regex/src/wide_posix_api.cpp
)
