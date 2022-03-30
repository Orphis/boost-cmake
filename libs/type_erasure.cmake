_add_boost_lib(
  NAME type_erasure
  SOURCES
    ${boost_SOURCE_DIR}/libs/type_erasure/src/dynamic_binding.cpp
  LINK
    Boost::thread
)
