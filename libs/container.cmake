_add_boost_lib(
  NAME container
  SOURCES
    ${boost_SOURCE_DIR}/libs/container/src/alloc_lib.c
    ${boost_SOURCE_DIR}/libs/container/src/dlmalloc.cpp
    ${boost_SOURCE_DIR}/libs/container/src/global_resource.cpp
    ${boost_SOURCE_DIR}/libs/container/src/monotonic_buffer_resource.cpp
    ${boost_SOURCE_DIR}/libs/container/src/pool_resource.cpp
    ${boost_SOURCE_DIR}/libs/container/src/synchronized_pool_resource.cpp
    ${boost_SOURCE_DIR}/libs/container/src/unsynchronized_pool_resource.cpp
  DEFINE_PRIVATE
    BOOST_CONTAINER_STATIC_LINK=1
)

_add_boost_test(
  NAME container_test
  LINK
    Boost::container
    Boost::timer
  TESTS
    RUN ${boost_SOURCE_DIR}/libs/container/test/alloc_basic_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/alloc_full_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/allocator_traits_test.cpp
    #RUN ${boost_SOURCE_DIR}/libs/container/test/deque_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_deque_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_flat_map_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_flat_set_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_list_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_map_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_set_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_slist_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_small_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_stable_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_static_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_string_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/explicit_inst_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/flat_map_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/flat_set_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/global_resource_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/insert_vs_emplace_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/list_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/map_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/memory_resource_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/monotonic_buffer_resource_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/node_handle_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/null_iterators_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pair_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_deque_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_flat_map_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_flat_set_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_list_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_map_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_set_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_slist_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_small_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_stable_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_static_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_string_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/pmr_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/polymorphic_allocator_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/resource_adaptor_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/scoped_allocator_adaptor_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/scoped_allocator_usage_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/set_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/slist_test.cpp
    #RUN ${boost_SOURCE_DIR}/libs/container/test/small_vector_test.cpp
    #RUN ${boost_SOURCE_DIR}/libs/container/test/stable_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/static_vector_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/string_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/synchronized_pool_resource_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/throw_exception_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/unsynchronized_pool_resource_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/container/test/uses_allocator_test.cpp
    #RUN ${boost_SOURCE_DIR}/libs/container/test/vector_test.cpp
)
