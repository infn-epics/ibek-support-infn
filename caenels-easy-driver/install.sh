#!/bin/bash
##########################################################################
##### install script for Modbus support modules ############################
##########################################################################


# ARGUMENTS:
#  $1 VERSION to install (must match repo tag)
VERSION=${1}
NAME=easy-driver-epics
ALIAS=caenels-easy-driver ## maybe ibek should support an alternate name for the support module?
# log output and abort on failure
set -xe

# get the source and fix up the configure/RELEASE files
ibek support git-clone --org https://github.com/CAENels/ ${NAME} ${VERSION}
ibek support register ${NAME}

# declare the libs and DBDs that are required in ioc/iocApp/src/Makefile
ibek support add-libs asyn devEasyDriver
ibek support add-dbds asyn.dbd drvAsynIPPort.dbd drvAsynSerialPort.dbd devEasyDriver.dbd


# Patches to the CONFIG_SITE
if [[ $TARGET_ARCHITECTURE == "rtems" ]]; then
    # don't build the test directories (they don't compile on RTEMS)
    sed -i '/DIRS += ${SUPPORT}/${NAME}.*test/d' Makefile
else
    ibek support add-config-macro ${NAME} TIRPC YES
fi

# compile the support module
ibek support compile ${NAME}

# prepare *.bob, *.pvi, *.ibek.support.yaml for access outside the container.
ibek support generate-links ${NAME}


