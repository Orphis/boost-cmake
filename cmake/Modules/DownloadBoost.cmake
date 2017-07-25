# Downloading to the binary dir provides a better isolation
# But in some circomstances, you want to share the download between multiple build folders
if(BOOST_DOWNLOAD_TO_BINARY_DIR)
  set(DOWNLOAD_PREFIX "${CMAKE_CURRENT_BINARY_DIR}")
else()
  set(DOWNLOAD_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}")
endif()

if(IS_DIRECTORY ${BOOST_ARCHIVE_DIRECTORY})
  message(STATUS "Using local directory to search for boost archive: ${BOOST_ARCHIVE_DIRECTORY}")
  set(USING_LOCAL_ARCHIVE TRUE)
  set(ARCHIVE_PREFIX ${BOOST_ARCHIVE_DIRECTORY})
else()
  set(USING_LOCAL_ARCHIVE FALSE)
  set(ARCHIVE_PREFIX ${DOWNLOAD_PREFIX})
endif()

get_filename_component(BOOST_URL_FILENAME "${BOOST_URL}" NAME)
set(DOWNLOAD_PATH "${ARCHIVE_PREFIX}/${BOOST_URL_FILENAME}")
set(EXTRACT_PATH "${DOWNLOAD_PREFIX}/boost")

# Check if the provided folder points to a valid installation
if(BOOST_SOURCE AND NOT IS_DIRECTORY "${BOOST_SOURCE}")
  message(WARNING "BOOST_SOURCE is pointing to a non existing folder, trying to download instead")
  unset(BOOST_SOURCE CACHE)
endif()

if(BOOST_SOURCE AND NOT EXISTS "${BOOST_SOURCE}/boost/version.hpp")
  message(FATAL_ERROR "Folder ${BOOST_SOURCE} points to an invalid Boost source folder")
endif()

# Check previously downloaded archive hash against the current one
if(BOOST_LOCAL_SHA256 AND NOT BOOST_LOCAL_SHA256 STREQUAL "${BOOST_URL_SHA256}")
  message(STATUS "New Boost version detected, removing older one")

  file(REMOVE_RECURSE "${EXTRACT_PATH}")
  file(REMOVE "${DOWNLOAD_PATH}")

  unset(BOOST_LOCAL_SHA256 CACHE)
  unset(BOOST_SOURCE CACHE)
endif()

if(NOT BOOST_SOURCE OR NOT EXISTS "${BOOST_SOURCE}")
  # Check existing file
  if(EXISTS "${DOWNLOAD_PATH}")
    file(SHA256 "${DOWNLOAD_PATH}" LOCAL_SHA256)
    if(NOT LOCAL_SHA256 STREQUAL "${BOOST_URL_SHA256}")
      # If the user specified a local archive, we fail permanently if the SHA doesn't match.
      # Furthermore, we do not remove local archives since we do not own them (they are maintained
      # by the user). We will not attempt to download archives if a local archive was specified.
      set(_error_msg "File ${DOWNLOAD_PATH} doesn't match the expected SHA256.\n Local ${LOCAL_SHA256} != Expected ${BOOST_URL_SHA256}")
      if(NOT USING_LOCAL_ARCHIVE)
        message(WARNING ${_error_msg})
        file(REMOVE "${DOWNLOAD_PATH}")
      else()
        message(FATAL_ERROR ${_error_msg})
      endif()
    endif()
  endif()

  if(NOT EXISTS "${DOWNLOAD_PATH}")
    # Remove partially downloaded file
    file(REMOVE "${DOWNLOAD_PATH}.tmp")

    message(STATUS "Downloading Boost from ${BOOST_URL}")
    file(DOWNLOAD ${BOOST_URL} "${DOWNLOAD_PATH}.tmp"
         EXPECTED_HASH SHA256=${BOOST_URL_SHA256}
         STATUS download_status
         LOG download_log
         SHOW_PROGRESS
    )
    list(GET download_status 0 download_status_code)
    list(GET download_status 1 download_status_message)
    if(download_status_code)
      file(REMOVE "${DOWNLOAD_PATH}.tmp")
      message(FATAL_ERROR "Download failed. Status: ${download_status_code} ${download_status_message}\nLog: ${download_log}")
    endif()

    file(RENAME "${DOWNLOAD_PATH}.tmp" "${DOWNLOAD_PATH}")
  endif()

  set(BOOST_LOCAL_SHA256 "${BOOST_URL_SHA256}" CACHE STRING "Current SHA256 of Boost archive used" FORCE)
  mark_as_advanced(BOOST_LOCAL_SHA256)

  if(NOT IS_DIRECTORY "${EXTRACT_PATH}")
    message(STATUS "Extracting Boost archive...")
    if(EXISTS "${EXTRACT_PATH}.tmp")
      file(REMOVE_RECURSE "${EXTRACT_PATH}.tmp")
    endif()
    file(MAKE_DIRECTORY "${EXTRACT_PATH}.tmp")
    execute_process(
      COMMAND ${CMAKE_COMMAND} -E tar xfv ${DOWNLOAD_PATH}
      WORKING_DIRECTORY "${EXTRACT_PATH}.tmp"
      OUTPUT_QUIET
    )
    file(RENAME "${EXTRACT_PATH}.tmp" "${EXTRACT_PATH}")
  endif()

  file(GLOB download_boost_root "${EXTRACT_PATH}/boost_*")
  if(download_boost_root)
    set(BOOST_SOURCE "${download_boost_root}" CACHE STRING "Boost location" FORCE)
  endif()
endif()

# Detect Boost version
file(STRINGS "${BOOST_SOURCE}/boost/version.hpp" boost_version_raw
  REGEX "define BOOST_VERSION "
)
string(REGEX MATCH "[0-9]+" boost_version_raw "${boost_version_raw}")
math(EXPR BOOST_VERSION_MAJOR "${boost_version_raw} / 100000")
math(EXPR BOOST_VERSION_MINOR "${boost_version_raw} / 100 % 1000")
math(EXPR BOOST_VERSION_PATCH "${boost_version_raw} % 100")
set(BOOST_VERSION "${BOOST_VERSION_MAJOR}.${BOOST_VERSION_MINOR}.${BOOST_VERSION_PATCH}")

message(STATUS "Boost found: ${BOOST_VERSION} ${BOOST_SOURCE}")

