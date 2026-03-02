#!/bin/bash
##########################################################################
##### install script for Menlo laser synchronization support modules  ####
##########################################################################

# ARGUMENTS:
#  $1 VERSION to install (must match repo tag)
VERSION=${1}
NAME=menlo
FOLDER=$(dirname $(readlink -f $0))

# log output and abort on failure
set -xe

# get the source and fix up the configure/RELEASE files
ibek support git-clone ${NAME} ${VERSION} --org https://github.com/infn-epics/
ibek support register ${NAME}

# declare the libs and DBDs that are required in ioc/iocApp/src/Makefile
ibek support add-libs menloSup
ibek support add-dbds menloSup.dbd

# Patches to the CONFIG_SITE
if [[ $EPICS_TARGET_ARCH == "RTEMS"* ]]; then
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
