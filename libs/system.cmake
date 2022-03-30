_add_boost_lib(
  NAME system
  SOURCES
    ${boost_SOURCE_DIR}/libs/system/src/error_code.cpp
  DEFINE_PRIVATE
    BOOST_SYSTEM_STATIC_LINK=1
)

_add_boost_test(
  NAME system_test
  LINK
    Boost::boost
  TESTS
    RUN ${boost_SOURCE_DIR}/libs/system/test/error_code_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/system/test/error_code_user_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/system/test/system_error_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/system/test/header_only_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/system/test/config_test.cpp
)
