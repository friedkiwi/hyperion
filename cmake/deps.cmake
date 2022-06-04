
find_package(Threads REQUIRED)
set(EXT_DEPS_LIBS "${CMAKE_THREAD_LIBS_INIT}")


find_package (BZip2)
if (BZIP2_FOUND)
    include_directories(${BZIP_INCLUDE_DIRS})
    set(EXT_DEPS_LIBS ${EXT_DEPS_LIBS} ${BZIP2_LIBRARIES} )
endif()

find_package(ZLIB)
if (ZLIB_FOUND)
    include_directories(${ZLIB_INCLUDE_DIRS})
    set(EXT_DEPS_LIBS ${EXT_DEPS_LIBS} ${ZLIB_LIBRARIES} )
    add_definitions(-DHAVE_ZLIB_H)
    add_definitions(-DHAVE_ZLIB)
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    # 64 bits
    set(EXTPKG_LIBS telnet64 SoftFloat64 crypto64 decNumber64)
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
    # 32 bits
    set(EXTPKG_LIBS telnet SoftFloat crypto decNumber)
endif()

if (NEED_LINKING_AGAINST_LIBM)
    set(EXT_DEPS_LIBS m ${EXT_DEPS_LIBS})
endif()

add_definitions(-DOPTION_HAO)