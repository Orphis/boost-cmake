# We currently don't require any compression or mapped file support.
# Additionally, we don't ship with libbz2, and can't compile 'bzip2.cpp'
_add_boost_lib(
  NAME iostreams
  SOURCES
    # ${BOOST_SOURCE}/libs/iostreams/src/bzip2.cpp
    ${BOOST_SOURCE}/libs/iostreams/src/file_descriptor.cpp
    # ${BOOST_SOURCE}/libs/iostreams/src/gzip.cpp
    ${BOOST_SOURCE}/libs/iostreams/src/mapped_file.cpp
    # ${BOOST_SOURCE}/libs/iostreams/src/zlib.cpp
)
