_add_boost_lib(
  NAME filesystem
  SOURCES
    ${BOOST_SOURCE}/libs/filesystem/src/codecvt_error_category.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/directory.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/exception.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/operations.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/path.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/path_traits.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/portability.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/unique_path.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/utf8_codecvt_facet.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/windows_file_codecvt.cpp
  DEFINE_PRIVATE
    BOOST_FILESYSTEM_STATIC_LINK=1
)

set_target_properties(Boost_filesystem PROPERTIES CXX_STANDARD_REQUIRED ON)
get_target_property(filesystemStandardVersion Boost_filesystem CXX_STANDARD)
if(${filesystemStandardVersion} LESS 20)
    target_compile_definitions(Boost_filesystem PUBLIC BOOST_FILESYSTEM_NO_CXX20_ATOMIC_REF)
endif()

_add_boost_test(
  NAME filesystem_test
  LINK
    Boost::filesystem
  TESTS
    RUN ${BOOST_SOURCE}/libs/filesystem/test/convenience_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/macro_default_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/odr1_test.cpp
        ${BOOST_SOURCE}/libs/filesystem/test/odr2_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/deprecated_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/fstream_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/large_file_support_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/locale_info.cpp
    #RUN ${BOOST_SOURCE}/libs/filesystem/test/operations_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/path_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/path_unit_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/relative_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/example/simple_ls.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/example/file_status.cpp
)
