# Define the header-only Boost targets
add_library(Boost::boost INTERFACE IMPORTED GLOBAL)
add_library(Boost::headers ALIAS Boost::boost)

target_include_directories(Boost::boost SYSTEM INTERFACE ${BOOST_SOURCE})
target_compile_features(Boost::boost INTERFACE cxx_std_${CMAKE_CXX_STANDARD})

# Disable autolink
target_compile_definitions(Boost::boost INTERFACE BOOST_ALL_NO_LIB=1)
