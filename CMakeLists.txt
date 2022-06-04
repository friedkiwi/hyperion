#
# SDL-Hercules CMakeList
#
#
cmake_minimum_required(VERSION 3.12)

project(hyperion)

#------------------------------------------------------------------------------
#   Load some handy CMake modules
#------------------------------------------------------------------------------

if( NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules" )
    message( FATAL_ERROR "CMake modules directory not found! ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules" )
else()
    set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules" )
    include(CheckHeaderFile)
    include(CheckSymbol)
endif()


# include EXTPKG's as git modules
add_subdirectory(crypto)
add_subdirectory(decNumber)
add_subdirectory(SoftFloat)
add_subdirectory(telnet)

# configure the build
configure_file(config.h.in ${CMAKE_CURRENT_BINARY_DIR}/config.h )

include(cmake/headers.cmake)
include(cmake/functions.cmake)
include(cmake/misc.cmake)
include(cmake/deps.cmake)

include_directories( BEFORE
        telnet/include
        telnet/
        crypto/include
        crypto/
        SoftFloat/source/include
        SoftFloat/
        decNumber/include
        decNumber/
        )

include(cmake/hdt.cmake)

# Internal libraries
add_library( hsys
        hsys.c
        )
target_link_libraries( hsys ${EXTPKG_LIBS})

add_library( hutil
        codepage.c
        hdl.c
        hexdumpe.c
        hostinfo.c
        hscutl.c
        hsocket.c
        hthreads.c
        logger.c
        logmsg.c
        machdep.c
        memrchr.c
        parser.c
        pttrace.c
        version.c
        )
target_link_libraries( hutil ${CMAKE_DL_LIBS} hsys)

add_library( htape
        hetlib.c
        ftlib.c
        sllib.c
        )
target_link_libraries(htape hsys hutil)

add_library( hdisk
        cache.c
        cckddasd.c
        cckdutil.c
        ckddasd.c
        cckddasd64.c
        cckdutil64.c
        ckddasd64.c
        dasdtab.c
        dasdutil.c
        fbadasd.c
        dasdutil64.c
        fbadasd64.c
        shared.c
        )
target_link_libraries( hdisk hsys)

add_library( herc
        _archdep_templ.c
        archlvl.c
        assist.c
        bldcfg.c
        cgibin.c
        channel.c
        chsc.c
        clock.c
        cmdtab.c
        cmpsc_2012.c
        cmpscdbg.c
        cmpscdct.c
        cmpscget.c
        cmpscmem.c
        cmpscput.c
        config.c
        control.c
        cpu.c
        crypto.c
        dat.c
        decimal.c
        dfp.c
        diagmssf.c
        diagnose.c
        dyn76.c
        ecpsvm.c
        esame.c
        external.c
        facility.c
        fillfnam.c
        float.c
        general1.c
        general2.c
        general3.c
        hao.c
        hbyteswp.c
        hconsole.c
        hdiagf18.c
        history.c
        hRexx.c
        hRexx_o.c
        hRexx_r.c
        hsccmd.c
        hscemode.c
        hscloc.c
        hscmisc.c
        hscpufun.c
        httpserv.c
        ieee.c
        impl.c
        inline.c
        io.c
        ipl.c
        loadmem.c
        loadparm.c
        losc.c
        machchk.c
        machdep.c
        opcode.c
        panel.c
        pfpo.c
        plo.c
        qdio.c
        scedasd.c
        scescsi.c
        script.c
        service.c
        sie.c
        skey.c
        sr.c
        stack.c
        strsignal.c
        tcpip.c
        timer.c
        trace.c
        transact.c
        vector.c
        vm.c
        vmd250.c
        vstore.c
        x75.c
        xstore.c
        )
target_link_libraries(herc hsys hutil htape hdisk)


#--------------------------------------------
#  executables
#--------------------------------------------

include(cmake/build_tools.cmake)

add_executable(hercules bootstrap.c)
target_link_libraries(hercules herc hsys hutil htape hdisk)
target_link_libraries(hercules ${EXT_DEPS_LIBS})