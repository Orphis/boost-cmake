# Define the header-only Boost target
add_library(Boost_boost INTERFACE)
add_library(Boost::boost ALIAS Boost_boost)
set_target_properties(Boost_boost PROPERTIES
  EXPORT_NAME "boost"
)

if(CMAKE_GENERATOR MATCHES "Xcode")
  # The CMake Xcode generator doesn't support system headers directly
  set_target_properties(Boost_boost PROPERTIES INTERFACE_COMPILE_OPTIONS "-isystem;${BOOST_SOURCE}"    )
else()
  set_target_properties(Boost_boost PROPERTIES INTERFACE_SYSTEM_INCLUDE_DIRECTORIES ${BOOST_SOURCE}    )
  set_target_properties(Boost_boost PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "$<BUILD_INTERFACE:${BOOST_SOURCE}>;$<INSTALL_INTERFACE:include>")
endif()
install(TARGETS Boost_boost DESTINATION lib EXPORT boost-libs)

# Disable autolink
set_property(TARGET Boost_boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_ALL_NO_LIB=1)

add_library(Boost::boost_imported INTERFACE IMPORTED)
set_target_properties(Boost::boost_imported PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${BOOST_SOURCE}")
