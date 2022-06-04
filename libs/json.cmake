_add_boost_lib(
  NAME json SOURCES ${BOOST_SOURCE}/libs/json/src/src.cpp DEFINE_PRIVATE BOOST_JSON_STATIC_LINK=1
  LINK Boost::container Boost::system Boost::boost
)

file(GLOB_RECURSE BOOST_JSON_TESTS_FILES ${BOOST_SOURCE}/libs/json/test/*.cpp)
list(FILTER
     BOOST_JSON_TESTS_FILES
     EXCLUDE
     REGEX
     .*/cmake_install_test/.*$
)
message(TRACE "RUN ${BOOST_JSON_TESTS_FILES}")

_add_boost_test(
  NAME json_test
  INCLUDE ${BOOST_SOURCE}/libs/json/test
  LINK Boost::json
  TESTS
  RUN ${BOOST_JSON_TESTS_FILES}
)

_add_boost_test(
  NAME json_test
  INCLUDE ${BOOST_SOURCE}/libs/json/test
  DEFINE BOOST_JSON_MAX_STRING_SIZE=1000 BOOST_JSON_MAX_STRUCTURED_SIZE=20 BOOST_JSON_STACK_BUFFER_SIZE=256
         BOOST_JSON_NO_LIB=1
  LINK Boost::boost
  TESTS
  RUN ${BOOST_SOURCE}/libs/json/test/limits.cpp ${BOOST_SOURCE}/libs/json/test/main.cpp
      ${BOOST_SOURCE}/libs/json/src/src.cpp
)
