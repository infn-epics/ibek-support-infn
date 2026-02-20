#!/bin/bash

# ARGUMENTS:
#  $1 VERSION to install (must match repo tag)
VERSION=${1}
NAME=technosoft-asyn
FOLDER=$(dirname $(readlink -f $0))

# log output and abort on failure
set -xe

# get the source
ibek support git-clone ${NAME} ${VERSION} --org https://github.com/infn-epics/
ibek support register ${NAME}

# declare the libs and DBDs that are required in ioc/iocApp/src/Makefile
ibek support add-libs technosoft TML_lib motor asyn
ibek support add-dbds devTechnosoft.dbd motorRecord.dbd motorSupport.dbd

# global config settings
${FOLDER}/../_global/install.sh ${NAME}

# compile the support module
ibek support compile ${NAME}

# configure runtime library paths for TML_lib
echo "${SUPPORT}/${NAME}/tml_lib/lib" > /etc/ld.so.conf.d/technosoft-tml.conf && ldconfig

# copy TML library and configs to assets
mkdir -p /assets/support/${NAME}/
cp -r /epics/support/${NAME}/tml_lib /assets/support/${NAME}/

# prepare *.bob, *.pvi, *.ibek.support.yaml for access outside the container.
ibek support generate-links ${FOLDER}
