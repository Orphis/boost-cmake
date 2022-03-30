_add_boost_lib(
  NAME program_options
  SOURCES
    ${boost_SOURCE_DIR}/libs/program_options/src/cmdline.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/config_file.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/options_description.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/parsers.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/variables_map.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/value_semantic.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/positional_options.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/utf8_codecvt_facet.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/convert.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/winmain.cpp
    ${boost_SOURCE_DIR}/libs/program_options/src/split.cpp
)

_add_boost_test(
  NAME program_options_test
  LINK
    Boost::program_options
  TESTS
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/options_description_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/variable_map_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/cmdline_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/positional_options_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/unicode_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/winmain.cpp
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/exception_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/split_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/unrecognized_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/program_options/test/exception_txt_test.cpp
)
