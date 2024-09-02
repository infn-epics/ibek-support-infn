#!/bin/bash
##########################################################################
##### install script for Modbus support modules ############################
##########################################################################


# ARGUMENTS:
#  $1 VERSION to install (must match repo tag)
VERSION=${1}
NAME=biltItest
FOLDER=$(dirname $(readlink -f $0))

# log output and abort on failure
set -xe

# get the source and fix up the configure/RELEASE files
ibek support git-clone ${NAME} ${VERSION} --org https://oauth2:zt_ALPjGqNRwLPeHMB8_@baltig.infn.it/infn-epics/
ibek support register ${NAME}
# None required for a stream device ------------------------------------

# declare the libs and DBDs that are required in ioc/iocApp/src/Makefile
ibek support add-libs asyn
ibek support add-dbds asyn.dbd
# global config settings
${FOLDER}/../_global/install.sh ${NAME}

# compile the support module
ibek support compile ${NAME}
# cp -i ${FOLDER}/db/* ${SUPPORT}/${NAME}/db
# prepare *.bob, *.pvi, *.ibek.support.yaml for access outside the container.
ibek support generate-links ${FOLDER}


