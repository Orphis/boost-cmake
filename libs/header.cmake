# Define the header-only Boost target
add_library(Boost::boost INTERFACE IMPORTED GLOBAL)
if(CMAKE_GENERATOR MATCHES "Xcode")
  # The CMake Xcode generator doesn't support system headers directly
  set_target_properties(Boost::boost PROPERTIES INTERFACE_COMPILE_OPTIONS "-isystem;${BOOST_SOURCE}"    )
else()
  set_target_properties(Boost::boost PROPERTIES INTERFACE_SYSTEM_INCLUDE_DIRECTORIES ${BOOST_SOURCE}    )
  set_target_properties(Boost::boost PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${BOOST_SOURCE})
endif()

# Disable autolink
set_property(TARGET Boost::boost APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS BOOST_ALL_NO_LIB=1)
