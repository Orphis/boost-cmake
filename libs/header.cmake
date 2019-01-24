# Define the header-only Boost target
add_library(Boost::boost INTERFACE IMPORTED GLOBAL)

# Disable autolink
target_compile_definitions(Boost::boost INTERFACE BOOST_ALL_NO_LIB=1)

if(BOOST_MODULARIZED)
  file(GLOB alllibs "${BOOST_SOURCE}/libs/*" "${BOOST_SOURCE}/libs/numeric/*")
  foreach(lib IN LISTS alllibs)
    if(IS_DIRECTORY "${lib}/include")
      target_include_directories(Boost::boost SYSTEM INTERFACE "${lib}/include")
    endif()
  endforeach()
else()
  target_include_directories(Boost::boost SYSTEM INTERFACE ${BOOST_SOURCE})
endif()
