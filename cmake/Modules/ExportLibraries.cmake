include(CMakePackageConfigHelpers)
write_basic_package_Version_file("BoostConfigVersion.cmake"
  VERSION ${BOOST_VERSION}
  COMPATIBILITY AnyNewerVersion)

get_property(BOOST_FIND_PACKAGE GLOBAL PROPERTY Boost_Find_Package)
if(BOOST_FIND_PACKAGE)
  # The list may be empty
  list(REMOVE_DUPLICATES BOOST_FIND_PACKAGE)
endif()
configure_file("BoostConfig.cmake.in" "${CMAKE_CURRENT_BINARY_DIR}/BoostConfig.cmake" @ONLY)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/BoostConfig.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/BoostConfigVersion.cmake"
  DESTINATION lib/cmake/Boost
)
install(DIRECTORY ${BOOST_SOURCE}/boost
  DESTINATION include
)
install(EXPORT boost-libs
  DESTINATION lib/cmake/Boost
  NAMESPACE Boost::
  FILE BoostTargets.cmake
)
