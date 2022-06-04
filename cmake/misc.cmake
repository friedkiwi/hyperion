# set version
if (WIN32)
    execute_process(COMMAND "${CMAKE_CURRENT_SOURCE_DIR}/_dynamic_version.cmd"
            WORKING_DIRECTORY  ${PROJECT_SOURCE_DIR}
            OUTPUT_VARIABLE DYNAMIC_VERSION
            )
else()
    execute_process(COMMAND "${CMAKE_CURRENT_SOURCE_DIR}/_dynamic_version"
            WORKING_DIRECTORY  ${PROJECT_SOURCE_DIR}
            OUTPUT_VARIABLE DYNAMIC_VERSION
            )
endif()

string (REGEX REPLACE "[\"\r\n]"  "" DYNAMIC_VERSION ${DYNAMIC_VERSION} )

add_definitions(-DDYNAMIC_VERSION=\"${DYNAMIC_VERSION}\")

# set host arch
add_definitions(-DHOST_ARCH=\"${CMAKE_SYSTEM_PROCESSOR}\")

add_definitions(-D_GNU_SOURCE)
if (MSVC)
    remove_definitions(-D_GNU_SOURCE)
    add_definitions(-D_MSVC_)
endif()

add_definitions(-DSIZEOF_INT_P=${CMAKE_SIZEOF_VOID_P})

if (UNIX)
    add_definitions(-DLTDL_SHLIB_EXT=".so")
endif()