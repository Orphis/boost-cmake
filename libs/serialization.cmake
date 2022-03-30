

if(USE_WINDOWS)
  set(SERIALIZATION_WIN_SRCS
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_text_wiprimitive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_text_woprimitive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/text_wiarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/text_woarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/xml_wgrammar.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/xml_wiarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/xml_woarchive.cpp
  )
  set(CXXFLAGS "/Gy")
endif()

_add_boost_lib(
  NAME serialization
  SOURCES
    ${SERIALIZATION_WIN_SRCS}
    ${boost_SOURCE_DIR}/libs/serialization/src/archive_exception.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_archive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_iarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_iserializer.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_oarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_oserializer.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_pointer_iserializer.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_pointer_oserializer.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_serializer_map.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_text_iprimitive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_text_oprimitive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_xml_archive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/basic_xml_grammar.ipp
    ${boost_SOURCE_DIR}/libs/serialization/src/binary_iarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/binary_oarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/binary_wiarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/binary_woarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/codecvt_null.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/extended_type_info.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/extended_type_info_no_rtti.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/extended_type_info_typeid.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/polymorphic_iarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/polymorphic_oarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/stl_port.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/text_iarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/text_oarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/utf8_codecvt_facet.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/void_cast.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/xml_archive_exception.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/xml_grammar.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/xml_iarchive.cpp
    ${boost_SOURCE_DIR}/libs/serialization/src/xml_oarchive.cpp
  CXXFLAGS_PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/Gy>
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-fvisibility=hidden -fvisibility-inlines-hidden -ftemplate-depth-255>
)
