#!/bin/bash

# ARGUMENTS:
#  $1 VERSION to install (must match repo tag)
VERSION=${1}
NAME=screen-epics-ioc
FOLDER=$(dirname $(readlink -f $0))

# log output and abort on failure
set -xe

# get the source and fix up the configure/RELEASE files
ibek support git-clone ${NAME} ${VERSION} --org https://github.com/lnls-dig/
ibek support register ${NAME}

# declare the libs and DBDs that are required in ioc/iocApp/src/Makefile
#ibek support add-libs motorSimSupport
ibek support add-dbds screen.dbd 

# global config settings
${FOLDER}/../_global/install.sh

# compile the support module
ibek support compile ${NAME}
# prepare *.bob, *.pvi, *.ibek.support.yaml for access outside the container.
ibek support generate-links ${FOLDER}


