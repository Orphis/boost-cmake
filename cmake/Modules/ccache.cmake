find_program(CCACHE_BIN NAMES ccache sccache)
if(CCACHE_BIN)
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_BIN} CACHE FILEPATH "CXX compiler cache used")
    set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE_BIN} CACHE FILEPATH "C compiler cache used")

    # ccache uses -I when compiling without preprocessor, which makes clang complain.
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Qunused-arguments -fcolor-diagnostics")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Qunused-arguments -fcolor-diagnostics")
    endif()
endif()
