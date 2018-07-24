#!/bin/bash
export RESOURCESPACE_MYSQL_DOCKER_VOLUME=myvol
if [ -z "${RESOURCESPACE_DIR}" ]
then
   >&2 echo "environment variable RESOURCESPACE_DIR is not set."
   exit 1
fi
if [ ! -d "${RESOURCESPACE_DIR}" ]
then
    >&2 echo "${RESOURCESPACE_DIR} does not exist or is not a folder."
    exit 1
fi
RESOURCESPACE_MYSQL_DOCKER_VOLUME_INSPECT_RESULT=$(docker volume inspect myvol)
>&2 echo "RESOURCESPACE_MYSQL_DOCKER_VOLUME_INSPECT_RESULT = ${RESOURCESPACE_MYSQL_DOCKER_VOLUME_INSPECT_RESULT}"
RESOURCESPACE_MYSQL_DOCKER_VOLUME_REMOVE_RESULT=$(docker volume rm ${RESOURCESPACE_MYSQL_DOCKER_VOLUME})
RESOURCESPACE_MYSQL_DOCKER_VOLUME_CREATE_RESULT=$(docker volume create ${RESOURCESPACE_MYSQL_DOCKER_VOLUME})
if (( $? != 0 ))
then
    >&2 echo ${RESOURCESPACE_MYSQL_DOCKER_VOLUME_CREATE_RESULT}
    >&2 echo "error creating volume ${RESOURCESPACE_MYSQL_DOCKER_VOLUME}."
fi
docker build -t dam . && docker run -it --rm -v "${RESOURCESPACE_MYSQL_DOCKER_VOLUME}:/var/lib/mysql" -v "${RESOURCESPACE_DIR}:/tmp/resourcespace" dam
