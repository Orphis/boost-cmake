_add_boost_lib(
  NAME container
  SOURCES
    ${BOOST_SOURCE}/libs/container/src/alloc_lib.c
    ${BOOST_SOURCE}/libs/container/src/dlmalloc.cpp
    ${BOOST_SOURCE}/libs/container/src/global_resource.cpp
    ${BOOST_SOURCE}/libs/container/src/monotonic_buffer_resource.cpp
    ${BOOST_SOURCE}/libs/container/src/pool_resource.cpp
    ${BOOST_SOURCE}/libs/container/src/synchronized_pool_resource.cpp
    ${BOOST_SOURCE}/libs/container/src/unsynchronized_pool_resource.cpp
  DEFINE_PRIVATE
    BOOST_CONTAINER_STATIC_LINK=1
)
