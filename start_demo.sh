#!/bin/sh

docker run --name=vaidy_demo -d \
    -p 8086:8086 \
    -v /data/logs:/data/logs \
    jvaidyaa/demo:latest

