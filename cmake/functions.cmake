
check_symbol("fsync" "unistd.h" HAVE_FSYNC)
check_symbol("setresuid" "unistd.h" HAVE_SETRESUID)
check_symbol("setreuid" "unistd.h" HAVE_SETREUID)
check_symbol("strsignal" "string.h" HAVE_STRSIGNAL)
check_symbol("strerror_r" "string.h" HAVE_STRERROR_R)


add_definitions(-DHAVE_STRUCT_IN_ADDR_S_ADDR)

