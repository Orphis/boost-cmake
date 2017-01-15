function(_add_boost_test)
  if(NOT BOOST_STANDALONE)
    return()
  endif()

  set(options)
  set(oneValueArgs NAME)
  set(multiValueArgs LINK DEFINE TESTS)
  cmake_parse_arguments(BOOSTTEST "${options}" "${oneValueArgs}"
                        "${multiValueArgs}" ${ARGN})

  # Split all arguments for TESTS in groups
  list(LENGTH BOOSTTEST_TESTS arg_len)
  set(arg_start 0)
  while(${arg_start} LESS ${arg_len})
    list(GET BOOSTTEST_TESTS ${arg_start} test_command)
    math(EXPR arg_start "${arg_start} + 1")
    unset(test_files)

    foreach(arg_pos RANGE ${arg_start} ${arg_len})
      set(arg_start ${arg_pos})
      if(arg_start EQUAL ${arg_len})
        break()
      endif()

      list(GET BOOSTTEST_TESTS ${arg_pos} arg)
      if(arg STREQUAL "RUN")
        break()
      else()
        list(APPEND test_files ${arg})
      endif()
    endforeach()

    if(test_command STREQUAL "RUN")
      if(NOT test_files)
        message(FATAL_ERROR "Missing files for test command ${test_command}")
      endif()
      list(GET test_files 0 main_src)
      get_filename_component(source_name ${main_src} NAME_WE)
      set(test_name Boost_${BOOSTTEST_NAME}_${source_name})
      add_executable(${test_name} ${test_files})
      add_test(NAME ${test_name}
        COMMAND ${test_name}
        WORKING_DIRECTORY ${BOOST_SOURCE}/status
      )
      if(MSVC)
        target_compile_options(${test_name} PRIVATE /bigobj)
      endif()
      if(NOT BOOST_STANDALONE)
        set_target_properties(${test_name} PROPERTIES EXCLUDE_FROM_ALL 1)
      endif()
      if(BOOSTTEST_DEFINE)
        target_compile_definitions(${test_name} PUBLIC ${BOOSTTEST_DEFINE})
      endif()
      if(BOOSTTEST_LINK)
        target_link_libraries(${test_name} PUBLIC ${BOOSTTEST_LINK})
      endif()
    else()
      message(FATAL_ERROR "Unknown test command: ${test_command}")
    endif()
  endwhile()
endfunction()
