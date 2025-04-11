#!/bin/bash
##########################################################################
##### install script for Modbus support modules ############################
##########################################################################


# ARGUMENTS:
#  $1 VERSION to install (must match repo tag)
VERSION=${1}
NAME=epics-nds
FOLDER=$(dirname $(readlink -f $0))

# log output and abort on failure
set -xe
ibek support add-runtime-packages libboost-dev libcurl4-gnutls-dev libboost-filesystem-dev
ibek support apt-install libboost-dev libcurl4-gnutls-dev libboost-filesystem-dev
# get the source and fix up the configure/RELEASE files

# TODO WARNING - looks like you leaked a token here?
ibek support git-clone ${NAME} ${VERSION} --org https://oauth2:zt_ALPjGqNRwLPeHMB8_@baltig.infn.it/infn-epics/
ibek support register ${NAME}

# declare the libs and DBDs that are required in ioc/iocApp/src/Makefile
ibek support add-libs nds asyn
ibek support add-dbds nds.dbd asyn.dbd
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
# prepare *.bob, *.pvi, *.ibek.support.yaml for access outside the container.
ibek support generate-links ${FOLDER}


