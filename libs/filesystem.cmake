_add_boost_lib(
  NAME filesystem
  SOURCES
    ${BOOST_SOURCE}/libs/filesystem/src/codecvt_error_category.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/operations.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/path.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/path_traits.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/portability.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/unique_path.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/utf8_codecvt_facet.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/windows_file_codecvt.cpp
  DEFINE_PRIVATE
    BOOST_FILESYSTEM_STATIC_LINK=1
  LINK
    Boost::system
)
