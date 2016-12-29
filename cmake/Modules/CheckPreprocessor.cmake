function(check_preprocessor output_variable symbol)
  if(DEFINED _check_preprocessor_cache_${symbol})
    set(${output_variable} "${_check_preprocessor_cache_${symbol}}")
    return()
  endif()

  enable_language(C)

set(_check_preprocessor_source "
#if defined(${symbol})
int main() { return 0; }
#endif
")

  set(_check_preprocessor_source_name "${CMAKE_CURRENT_BINARY_DIR}/check_preprocessor.c")
  file(WRITE "${_check_preprocessor_source_name}" "${_check_preprocessor_source}")

  try_compile(_check_preprocessor_result "${CMAKE_BINARY_DIR}" "${_check_preprocessor_source_name}")
  file(REMOVE "${_check_preprocessor_source_name}")


  if(_check_preprocessor_result)
    set(_check_preprocessor_cache_${symbol} TRUE CACHE STRING "" FORCE)
  else()
    set(_check_preprocessor_cache_${symbol} FALSE CACHE STRING "" FORCE)
  endif()
  mark_as_advanced(_check_preprocessor_cache_${symbol})

  set(${output_variable} "${_check_preprocessor_cache_${symbol}}" PARENT_SCOPE)
endfunction()

