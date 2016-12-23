_add_boost_lib(
  NAME date_time
  SOURCES
    ${BOOST_SOURCE}/libs/date_time/src/gregorian/greg_month.cpp
    ${BOOST_SOURCE}/libs/date_time/src/gregorian/greg_weekday.cpp
    ${BOOST_SOURCE}/libs/date_time/src/gregorian/date_generators.cpp
  DEFINE_PRIVATE
    BOOST_DATE_TIME_STATIC_LINK
    DATE_TIME_INLINE
)
