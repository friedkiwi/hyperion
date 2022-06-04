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
check_symbol("strsignal" "string.h" HAVE_STRSIGNAL)
check_symbol("strerror_r" "string.h" HAVE_STRERROR_R)


add_definitions(-DHAVE_STRUCT_IN_ADDR_S_ADDR)

