_add_boost_lib(
  NAME graph
  SOURCES
    ${boost_SOURCE_DIR}/libs/graph/src/graphml.cpp
    ${boost_SOURCE_DIR}/libs/graph/src/read_graphviz_new.cpp
  LINK Boost::regex
)
