#!/bin/bash
##########################################################################
##### install script for Modbus support modules ############################
##########################################################################


# ARGUMENTS:
#  $1 VERSION to install (must match repo tag)
VERSION=${1}
NAME=motorTechnosoft
FOLDER=$(dirname $(readlink -f $0))

# log output and abort on failure
set -xe

ibek support apt-install libboost-dev socat
# get the source and fix up the configure/RELEASE files
ibek support git-clone ${NAME} ${VERSION} --org https://oauth2:zt_ALPjGqNRwLPeHMB8_@baltig.infn.it/infn-epics/

ibek support register ${NAME}

# declare the libs and DBDs that are required in ioc/iocApp/src/Makefile
ibek support add-libs nds seq FLGShift tml
ibek support add-dbds tml.dbd nds.dbd asyn.dbd FLGShift.dbd
# Patches to the CONFIG_SITE
if [[ $EPICS_TARGET_ARCH == "RTEMS"* ]]; then
    # don't build the test directories (they don't compile on RTEMS)
    sed -i '/DIRS += ${SUPPORT}/${NAME}.*test/d' Makefile
else
    ibek support add-config-macro ${NAME} TIRPC YES
fi

# global config settings
${FOLDER}/../_global/install.sh ${NAME}
# compile the support module
ibek support compile ${NAME}
cp -i ${SUPPORT}/${NAME}/tml_lib/lib/* /usr/lib/x86_64-linux-gnu/
# socat pty,link=/var/tmp/ttyV0,raw,echo=0,b9600 tcp:192.168.190.55:4001
# prepare *.bob, *.pvi, *.ibek.support.yaml for access outside the container.
ibek support generate-links ${FOLDER}



