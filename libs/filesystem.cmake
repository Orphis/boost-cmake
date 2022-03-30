_add_boost_lib(
  NAME filesystem
  SOURCES
    ${boost_SOURCE_DIR}/libs/filesystem/src/codecvt_error_category.cpp
    ${boost_SOURCE_DIR}/libs/filesystem/src/operations.cpp
    ${boost_SOURCE_DIR}/libs/filesystem/src/path.cpp
    ${boost_SOURCE_DIR}/libs/filesystem/src/path_traits.cpp
    ${boost_SOURCE_DIR}/libs/filesystem/src/portability.cpp
    ${boost_SOURCE_DIR}/libs/filesystem/src/unique_path.cpp
    ${boost_SOURCE_DIR}/libs/filesystem/src/utf8_codecvt_facet.cpp
    ${boost_SOURCE_DIR}/libs/filesystem/src/windows_file_codecvt.cpp
  DEFINE_PRIVATE
    BOOST_FILESYSTEM_STATIC_LINK=1
)

_add_boost_test(
  NAME filesystem_test
  LINK
    Boost::filesystem
  TESTS
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/convenience_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/macro_default_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/odr1_test.cpp
        ${boost_SOURCE_DIR}/libs/filesystem/test/odr2_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/deprecated_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/fstream_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/large_file_support_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/locale_info.cpp
    #RUN ${boost_SOURCE_DIR}/libs/filesystem/test/operations_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/path_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/path_unit_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/test/relative_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/example/simple_ls.cpp
    RUN ${boost_SOURCE_DIR}/libs/filesystem/example/file_status.cpp
)
