# Detect Boost version
if(EXISTS "${BOOST_SOURCE}/boost/version.hpp")
  set(BOOST_MODULARIZED FALSE)
  set(boost_version_file "${BOOST_SOURCE}/boost/version.hpp")
  message(STATUS "Boost format: archive")
elseif(EXISTS "${BOOST_SOURCE}/libs/config/include/boost/version.hpp")
  set(BOOST_MODULARIZED TRUE)
  set(boost_version_file "${BOOST_SOURCE}/libs/config/include/boost/version.hpp")
  message(STATUS "Boost format: modularized")
endif()

file(STRINGS "${boost_version_file}" boost_version_raw
  REGEX "define BOOST_VERSION "
)
string(REGEX MATCH "[0-9]+" boost_version_raw "${boost_version_raw}")
math(EXPR BOOST_VERSION_MAJOR "${boost_version_raw} / 100000")
math(EXPR BOOST_VERSION_MINOR "${boost_version_raw} / 100 % 1000")
math(EXPR BOOST_VERSION_PATCH "${boost_version_raw} % 100")
set(BOOST_VERSION "${BOOST_VERSION_MAJOR}.${BOOST_VERSION_MINOR}.${BOOST_VERSION_PATCH}")

unset(boost_version_raw)
unset(boost_version_file)
