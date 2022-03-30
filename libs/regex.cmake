_add_boost_lib(
  NAME regex
  SOURCES
    ${boost_SOURCE_DIR}/libs/regex/src/posix_api.cpp
    ${boost_SOURCE_DIR}/libs/regex/src/regex.cpp
    ${boost_SOURCE_DIR}/libs/regex/src/regex_debug.cpp
    ${boost_SOURCE_DIR}/libs/regex/src/static_mutex.cpp
    ${boost_SOURCE_DIR}/libs/regex/src/wide_posix_api.cpp
)
