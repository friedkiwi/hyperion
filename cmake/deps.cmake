
find_package(Threads REQUIRED)
set(EXT_DEPS_LIBS "${CMAKE_THREAD_LIBS_INIT}")


find_package (BZip2)
if (BZIP2_FOUND)
    include_directories(${BZIP_INCLUDE_DIRS})
    set(EXT_DEPS_LIBS ${EXT_DEPS_LIBS} ${BZIP2_LIBRARIES} )
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    # 64 bits
    set(EXTPKG_LIBS telnet64 SoftFloat64 crypto64 decNumber64)
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
    # 32 bits
    set(EXTPKG_LIBS telnet SoftFloat crypto decNumber)
endif()