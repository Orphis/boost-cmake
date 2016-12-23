_add_boost_lib(
  NAME program_options
  SOURCES
    ${BOOST_SOURCE}/libs/program_options/src/cmdline.cpp
    ${BOOST_SOURCE}/libs/program_options/src/config_file.cpp
    ${BOOST_SOURCE}/libs/program_options/src/options_description.cpp
    ${BOOST_SOURCE}/libs/program_options/src/parsers.cpp
    ${BOOST_SOURCE}/libs/program_options/src/variables_map.cpp
    ${BOOST_SOURCE}/libs/program_options/src/value_semantic.cpp
    ${BOOST_SOURCE}/libs/program_options/src/positional_options.cpp
    ${BOOST_SOURCE}/libs/program_options/src/utf8_codecvt_facet.cpp
    ${BOOST_SOURCE}/libs/program_options/src/convert.cpp
    ${BOOST_SOURCE}/libs/program_options/src/winmain.cpp
    ${BOOST_SOURCE}/libs/program_options/src/split.cpp
)
