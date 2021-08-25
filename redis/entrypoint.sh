#!/bin/bash

sed "s/^port 6379$/port ${LISTEN_PORT}/g" -i "${WORK_DIR}"/etc/redis.conf
sed "s|^dir .\/$|dir ${WORK_DIR}\/var|g" -i "${WORK_DIR}"/etc/redis.conf
sed "s/^bind 127.0.0.1 -::1$/bind 0.0.0.0/g" -i "${WORK_DIR}"/etc/redis.conf
sed "s/^dbfilename dump.rdb$/dbfilename ${DB_FILENAME}/g" -i "${WORK_DIR}"/etc/redis.conf

redis-server "${WORK_DIR}"/etc/redis.conf