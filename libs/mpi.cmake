find_package(MPI QUIET)

if(NOT MPI_CXX_FOUND)
  return()
endif()

_add_boost_lib(
  NAME mpi
  SOURCES
    ${boost_SOURCE_DIR}/libs/mpi/src/content_oarchive.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/environment.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/exception.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/graph_communicator.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/group.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/intercommunicator.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/mpi_datatype_cache.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/mpi_datatype_oarchive.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/packed_iarchive.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/packed_oarchive.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/packed_skeleton_iarchive.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/packed_skeleton_oarchive.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/point_to_point.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/request.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/text_skeleton_oarchive.cpp
    ${boost_SOURCE_DIR}/libs/mpi/src/timer.cpp
  DEFINE_PRIVATE
    BOOST_MPI_SOURCE=1
  LINK
    Boost::serialization
)
target_include_directories(Boost_mpi PUBLIC ${MPI_CXX_INCLUDE_PATH})
target_link_libraries(Boost_mpi PUBLIC ${MPI_CXX_LINK_FLAGS} ${MPI_CXX_LIBRARIES})
