# HDT modules
add_library(hdt1403 SHARED printer.c sockdev.c)
set_target_properties(hdt1403 PROPERTIES PREFIX "")

add_library(dyncrypt SHARED dyncrypt.c)
set_target_properties(dyncrypt PROPERTIES PREFIX "")

add_library(dyngui SHARED dyngui.c)
set_target_properties(dyngui PROPERTIES PREFIX "")

add_library(hdteq SHARED hdteq.c)
set_target_properties(hdteq PROPERTIES PREFIX "")

add_library(hdt2880 SHARED hchan.c)
set_target_properties(hdt2880 PROPERTIES PREFIX "")

add_library(hdt2703 SHARED commadpt.c)
set_target_properties(hdt2703 PROPERTIES PREFIX "")

add_library(hdttcpnje SHARED tcpnje.c)
set_target_properties(hdttcpnje PROPERTIES PREFIX "")

add_library(hdt3705 SHARED comm3705.c)
set_target_properties(hdt3705 PROPERTIES PREFIX "")

add_library(hdt3088 SHARED ctc_lcs.c ctc_ctci.c ctcadpt.c tuntap.c netsupp.c )
set_target_properties(hdt3088 PROPERTIES PREFIX "")

add_library(hdt3270 SHARED console.c)
set_target_properties(hdt3270 PROPERTIES PREFIX "")

add_library(hdt3420 SHARED tapedev.c tapeccws.c awstape.c faketape.c hettape.c omatape.c scsitape.c scsiutil.c)
set_target_properties(hdt3420 PROPERTIES PREFIX "")
add_library(hdt3420_not_mod tapedev.c tapeccws.c awstape.c faketape.c hettape.c omatape.c scsitape.c scsiutil.c)

add_library(hdt3505 SHARED cardrdr.c sockdev.c)
set_target_properties(hdt3505 PROPERTIES PREFIX "")

add_library(hdt3525 SHARED cardpch.c)
set_target_properties(hdt3525 PROPERTIES PREFIX "")

add_library(hdtqeth SHARED qeth.c mpc.c resolve.c tuntap.c)
set_target_properties(hdtqeth PROPERTIES PREFIX "")

add_library(hdtzfcp SHARED zfcp.c)
set_target_properties(hdtzfcp PROPERTIES PREFIX "")

add_library(hdt1052c SHARED con1052c.c)
set_target_properties(hdt1052c PROPERTIES PREFIX "")

add_library(hdtptp SHARED ctc_ptp.c mpc.c resolve.c tuntap.c)
set_target_properties(hdtptp PROPERTIES PREFIX "")

add_library(hdtdummy SHARED dummydev.c)
set_target_properties(hdtdummy PROPERTIES PREFIX "")