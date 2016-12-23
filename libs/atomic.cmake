_add_boost_lib(
  NAME atomic
  SOURCES
    ${BOOST_SOURCE}/libs/atomic/src/lockpool.cpp
  DEFINE_PRIVATE
    BOOST_ATOMIC_STATIC_LINK=1
    BOOST_ATOMIC_SOURCE
)
