include(CheckFunctionExists)

if(NOT POW_FUNCTION_EXISTS AND NOT NEED_LINKING_AGAINST_LIBM)
    CHECK_FUNCTION_EXISTS(pow POW_FUNCTION_EXISTS)
    if(NOT POW_FUNCTION_EXISTS)
        unset(POW_FUNCTION_EXISTS CACHE)
        list(APPEND CMAKE_REQUIRED_LIBRARIES m)
        CHECK_FUNCTION_EXISTS(pow POW_FUNCTION_EXISTS)
        if(POW_FUNCTION_EXISTS)
            set(NEED_LINKING_AGAINST_LIBM True CACHE BOOL "" FORCE)
        else()
            message(FATAL_ERROR "Failed making the pow() function available")
        endif()
    endif()
endif()


check_symbol("fsync" "unistd.h" HAVE_FSYNC)
check_symbol("setresuid" "unistd.h" HAVE_SETRESUID)
check_symbol("setreuid" "unistd.h" HAVE_SETREUID)
check_symbol("getopt_long" "unistd.h" HAVE_GETOPT_LONG)
check_symbol("optreset" "unistd.h" HAVE_OPTRESET)
check_symbol("geteuid" "unistd.h" HAVE_GETEUID)


check_symbol("strsignal" "string.h" HAVE_STRSIGNAL)
check_symbol("strerror_r" "string.h" HAVE_STRERROR_R)

check_symbol("SIOCADDRT" "sys/ioctl.h" HAVE_DECL_SIOCADDRT)

check_symbol("gettimeofday" "sys/time.h" HAVE_GETTIMEOFDAY)

check_symbol("mlock" "sys/mman.h" HAVE_MLOCK)
check_symbol("mlockall" "sys/mman.h" HAVE_MLOCKALL)

check_symbol("inet_aton" "arpa/inet.h" HAVE_INET_ATON)

check_symbol("nanosleep" "time.h" HAVE_NANOSLEEP)

check_symbol("alphasort" "dirent.h" HAVE_ALPHASORT)

check_symbol("setsockopt" "sys/socket.h" HAVE_BASIC_KEEPALIVE)
if (HAVE_BASIC_KEEPALIVE)
    add_definitions(-DHAVE_PARTIAL_KEEPALIVE)
    add_definitions(-DHAVE_FULL_KEEPALIVE)
endif()



add_definitions(-DHAVE_STRUCT_IN_ADDR_S_ADDR)

