if(USE_WINDOWS)
  set(BOOST_LOCALE_ENABLE_WINAPI_BACKEND_DEFAULT ON)
else()
  set(BOOST_LOCALE_ENABLE_WINAPI_BACKEND_DEFAULT OFF)
endif()

if(USE_FREEBSD)
  try_compile(HAVE_FREEBSD_XLOCALE
    "${CMAKE_CURRENT_BINARY_DIR}"
    "${boost_SOURCE_DIR}/libs/locale/build/has_xlocale.cpp"
  )
endif()
if(USE_LINUX OR USE_APPLE OR (USE_FREEBSD AND HAVE_FREEBSD_XLOCALE))
  set(BOOST_LOCALE_ENABLE_POSIX_BACKEND_DEFAULT ON)
else()
  set(BOOST_LOCALE_ENABLE_POSIX_BACKEND_DEFAULT OFF)
endif()

option(BOOST_LOCALE_ENABLE_ICU_BACKEND "Enable ICU backend in Boost Locale if available" ON)
option(BOOST_LOCALE_ENABLE_ICONV_BACKEND "Enable Iconv backend in Boost Locale if available" ON)
option(BOOST_LOCALE_ENABLE_WINAPI_BACKEND "Enable Winapi backend in Boost Locale if available" ${BOOST_LOCALE_ENABLE_WINAPI_BACKEND_DEFAULT})
option(BOOST_LOCALE_ENABLE_STD_BACKEND "Enable STD backend in Boost Locale if available" ON)
option(BOOST_LOCALE_ENABLE_POSIX_BACKEND "Enable Posix backend in Boost Locale if available" ${BOOST_LOCALE_ENABLE_POSIX_BACKEND_DEFAULT})

if(BOOST_LOCALE_ENABLE_ICU_BACKEND)
  find_package(ICU COMPONENTS uc dt i18n)
endif()

if(BOOST_LOCALE_ENABLE_ICONV_BACKEND)
  find_package(Iconv)
endif()

if(NOT ICU_FOUND AND NOT ICONV_FOUND AND NOT USE_WINDOWS)
  message(STATUS "Boost locale unsupported on platform: need either iconv or ICU.")
  return()
endif()

_add_boost_lib(
  NAME locale
  SOURCES
    ${ICU_SRCS}
    ${boost_SOURCE_DIR}/libs/locale/src/encoding/codepage.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/shared/date_time.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/shared/format.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/shared/formatting.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/shared/generator.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/shared/ids.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/shared/localization_backend.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/shared/message.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/shared/mo_lambda.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/util/codecvt_converter.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/util/default_locale.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/util/info.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/util/locale_data.cpp
)

# Convenience interface library to link deps to both main library and tests
add_library(Boost_locale_deps INTERFACE)
target_link_libraries(Boost_locale PRIVATE Boost_locale_deps)

if(BOOST_LOCALE_ENABLE_ICU_BACKEND AND ICU_FOUND)
  target_sources(Boost_locale PRIVATE
    ${boost_SOURCE_DIR}/libs/locale/src/icu/boundary.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/icu/codecvt.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/icu/collator.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/icu/conversion.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/icu/date_time.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/icu/formatter.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/icu/icu_backend.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/icu/numeric.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/icu/time_zone.cpp
  )
  target_link_libraries(Boost_locale_deps INTERFACE
    Boost::thread
    ICU::dt
    ICU::i18n
    ICU::uc
  )
  target_compile_definitions(Boost_locale_deps INTERFACE BOOST_LOCALE_WITH_ICU=1)
endif()

if(BOOST_LOCALE_ENABLE_STD_BACKEND)
  target_sources(Boost_locale PRIVATE
    ${boost_SOURCE_DIR}/libs/locale/src/std/codecvt.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/std/collate.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/std/converter.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/std/numeric.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/std/std_backend.cpp
  )
else()
  target_compile_definitions(Boost_locale_deps INTERFACE BOOST_LOCALE_NO_STD_BACKEND=1)
endif()

if(BOOST_LOCALE_ENABLE_ICONV_BACKEND AND ICONV_FOUND)
  target_link_libraries(Boost_locale_deps INTERFACE
    Iconv::Iconv
  )
  target_compile_definitions(Boost_locale_deps INTERFACE BOOST_LOCALE_WITH_ICONV=1)
endif()

if(BOOST_LOCALE_ENABLE_WINAPI_BACKEND)
  target_sources(Boost_locale PRIVATE
    ${boost_SOURCE_DIR}/libs/locale/src/win32/collate.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/win32/converter.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/win32/numeric.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/win32/win_backend.cpp
  )
else()
  target_compile_definitions(Boost_locale_deps INTERFACE BOOST_LOCALE_NO_WINAPI_BACKEND=1)
endif()

if(BOOST_LOCALE_ENABLE_POSIX_BACKEND)
  target_sources(Boost_locale PRIVATE
    ${boost_SOURCE_DIR}/libs/locale/src/posix/collate.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/posix/converter.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/posix/numeric.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/posix/codecvt.cpp
    ${boost_SOURCE_DIR}/libs/locale/src/posix/posix_backend.cpp
  )
else()
  target_compile_definitions(Boost_locale_deps INTERFACE BOOST_LOCALE_NO_POSIX_BACKEND=1)
endif()

if(USE_WINDOWS AND (BOOST_LOCALE_ENABLE_WINAPI_BACKEND OR BOOST_LOCALE_ENABLE_STD_BACKEND))
  target_sources(Boost_locale PRIVATE
    ${boost_SOURCE_DIR}/libs/locale/src/win32/lcid.cpp
  )
endif()

if(BOOST_LOCALE_ENABLE_POSIX_BACKEND
  OR BOOST_LOCALE_ENABLE_STD_BACKEND
  OR BOOST_LOCALE_ENABLE_WINAPI_BACKEND)
  target_sources(Boost_locale PRIVATE
    ${boost_SOURCE_DIR}/libs/locale/src/util/gregorian.cpp
  )
endif()

_add_boost_test(
  NAME locale_test
  LINK
    Boost::locale
    Boost_locale_deps
  TESTS
    # Configuration information
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_config.cpp

    # Shared
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_utf.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_date_time.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_ios_prop.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_codecvt.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_codepage_converter.cpp
    # RUN ${boost_SOURCE_DIR}/libs/locale/test/test_codepage.cpp
    # RUN ${boost_SOURCE_DIR}/libs/locale/test/test_message.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_generator.cpp

    # icu
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_collate.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_convert.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_boundary.cpp
    # RUN ${boost_SOURCE_DIR}/libs/locale/test/test_formatting.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_icu_vs_os_timezone.cpp

    # winapi
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_winapi_collate.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_winapi_convert.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_winapi_formatting.cpp

    # posix
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_posix_collate.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_posix_convert.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_posix_formatting.cpp

    # std
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_std_collate.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_std_convert.cpp
    RUN ${boost_SOURCE_DIR}/libs/locale/test/test_std_formatting.cpp
)
