_add_boost_lib(
  NAME signals
  SOURCES
    ${BOOST_SOURCE}/libs/signals/src/connection.cpp
    ${BOOST_SOURCE}/libs/signals/src/named_slot_map.cpp
    ${BOOST_SOURCE}/libs/signals/src/signal_base.cpp
    ${BOOST_SOURCE}/libs/signals/src/slot.cpp
    ${BOOST_SOURCE}/libs/signals/src/trackable.cpp
)
