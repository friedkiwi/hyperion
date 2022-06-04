# tools
add_executable(dasdinit dasdinit.c)
target_link_libraries(dasdinit hsys hutil htape hdisk herc )
target_link_libraries(dasdinit ${EXT_DEPS_LIBS})

add_executable(dasdinit64 dasdinit64.c)
target_link_libraries(dasdinit64 hsys hutil htape hdisk herc )
target_link_libraries(dasdinit64 ${EXT_DEPS_LIBS})

add_executable(dasdisup dasdisup.c)
target_link_libraries(dasdisup hsys hutil htape hdisk herc )
target_link_libraries(dasdisup ${EXT_DEPS_LIBS})

add_executable(dasdload dasdload.c)
target_link_libraries(dasdload hsys hutil htape hdisk herc )
target_link_libraries(dasdload ${EXT_DEPS_LIBS})

add_executable(dasdload64 dasdload64.c)
target_link_libraries(dasdload64 hsys hutil htape hdisk herc )
target_link_libraries(dasdload64 ${EXT_DEPS_LIBS})

add_executable(dasdconv dasdconv.c)
target_link_libraries(dasdconv hsys hutil htape hdisk herc )
target_link_libraries(dasdconv ${EXT_DEPS_LIBS})

add_executable(dasdconv64 dasdconv64.c)
target_link_libraries(dasdconv64 hsys hutil htape hdisk herc )
target_link_libraries(dasdconv64 ${EXT_DEPS_LIBS})

add_executable(dasdls dasdls.c)
target_link_libraries(dasdls hsys hutil htape hdisk herc )
target_link_libraries(dasdls ${EXT_DEPS_LIBS})

add_executable(dasdcat dasdcat.c)
target_link_libraries(dasdcat hsys hutil htape hdisk herc )
target_link_libraries(dasdcat ${EXT_DEPS_LIBS})

add_executable(dasdpdsu dasdpdsu.c)
target_link_libraries(dasdpdsu hsys hutil htape hdisk herc )
target_link_libraries(dasdpdsu ${EXT_DEPS_LIBS})

add_executable(dasdseq dasdseq.c)
target_link_libraries(dasdseq hsys hutil htape hdisk herc )
target_link_libraries(dasdseq ${EXT_DEPS_LIBS})

add_executable(dasdser dasdser.c)
target_link_libraries(dasdser hsys hutil htape hdisk herc )
target_link_libraries(dasdser ${EXT_DEPS_LIBS})

add_executable(maketape maketape.c)
target_link_libraries(maketape hsys hutil htape hdisk herc )
target_link_libraries(maketape ${EXT_DEPS_LIBS})

add_executable(tapecopy tapecopy.c scsiutil.c)
target_link_libraries(tapecopy hsys hutil htape hdisk herc )
target_link_libraries(tapecopy ${EXT_DEPS_LIBS})

add_executable(tapemap tapemap.c)
target_link_libraries(tapemap hsys hutil htape hdisk herc )
target_link_libraries(tapemap ${EXT_DEPS_LIBS})

add_executable(tapesplt tapesplt.c)
target_link_libraries(tapesplt hsys hutil htape hdisk herc )
target_link_libraries(tapesplt ${EXT_DEPS_LIBS})

add_executable(cckdcdsk cckdcdsk.c)
target_link_libraries(cckdcdsk hsys hutil htape hdisk herc )
target_link_libraries(cckdcdsk ${EXT_DEPS_LIBS})

add_executable(cckdcomp cckdcomp.c)
target_link_libraries(cckdcomp hsys hutil htape hdisk herc )
target_link_libraries(cckdcomp ${EXT_DEPS_LIBS})

add_executable(cckddiag cckddiag.c)
target_link_libraries(cckddiag hsys hutil htape hdisk herc )
target_link_libraries(cckddiag ${EXT_DEPS_LIBS})

add_executable(cckdcdsk64 cckdcdsk64.c)
target_link_libraries(cckdcdsk64 hsys hutil htape hdisk herc )
target_link_libraries(cckdcdsk64 ${EXT_DEPS_LIBS})

add_executable(cckdcomp64 cckdcomp64.c)
target_link_libraries(cckdcomp64 hsys hutil htape hdisk herc )
target_link_libraries(cckdcomp64 ${EXT_DEPS_LIBS})

add_executable(dasdcopy dasdcopy.c)
target_link_libraries(dasdcopy hsys hutil htape hdisk herc )
target_link_libraries(dasdcopy ${EXT_DEPS_LIBS})

add_executable(dasdcopy64 dasdcopy.c)
target_link_libraries(dasdcopy64 hsys hutil htape hdisk herc )
target_link_libraries(dasdcopy64 ${EXT_DEPS_LIBS})

add_executable(cckdswap cckdswap.c)
target_link_libraries(cckdswap hsys hutil htape hdisk herc )
target_link_libraries(cckdswap ${EXT_DEPS_LIBS})

add_executable(cckdswap64 cckdswap.c)
target_link_libraries(cckdswap64 hsys hutil htape hdisk herc )
target_link_libraries(cckdswap64 ${EXT_DEPS_LIBS})

add_executable(cckdmap cckdmap.c)
target_link_libraries(cckdmap hsys hutil htape hdisk herc )
target_link_libraries(cckdmap ${EXT_DEPS_LIBS})

add_executable(convto64 convto64.c)
target_link_libraries(convto64 hsys hutil htape hdisk herc )
target_link_libraries(convto64 ${EXT_DEPS_LIBS})

add_executable(hetget hetget.c)
target_link_libraries(hetget hsys hutil htape hdisk herc )
target_link_libraries(hetget ${EXT_DEPS_LIBS})

add_executable(hetinit hetinit.c)
target_link_libraries(hetinit hsys hutil htape hdisk herc )
target_link_libraries(hetinit ${EXT_DEPS_LIBS})

add_executable(hetmap hetmap.c)
target_link_libraries(hetmap hsys hutil htape hdisk herc )
target_link_libraries(hetmap ${EXT_DEPS_LIBS})

add_executable(hetupd hetupd.c)
target_link_libraries(hetupd hsys hutil htape hdisk herc )
target_link_libraries(hetupd ${EXT_DEPS_LIBS})

add_executable(dmap2hrc dmap2hrc.c)
target_link_libraries(dmap2hrc hsys hutil htape hdisk herc )
target_link_libraries(dmap2hrc ${EXT_DEPS_LIBS})

add_executable(vmfplc2 vmfplc2.c)
target_link_libraries(vmfplc2 hdt3420_not_mod hsys hutil htape hdisk herc )
target_link_libraries(vmfplc2 ${EXT_DEPS_LIBS})