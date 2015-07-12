#!/bin/sh

set -eu

export INSTANCE_ID=`cat /etc/hostname`

stop() {
    set +e
    echo '>>>>> Shutting down services...' >&2

    echo '>>>>> Stopping parconapi...'
    kill -TERM $webapp_pid

    wait $webapp_pid
}
trap stop TERM

echo '>>>>> Starting demo...'
cd /data; \
export JAVA_HOME=/jdk1.8.0_25
${JAVA_HOME}/bin/java -Xms256m -Xmx2048m -jar demo.war  >> logs/console.log 2>&1 &
webapp_pid=$!

echo '>>>>> Services started successfully'

# Wait for background processes
set +e
wait $webapp_pid

echo ">>>>> Container shutdown at $(date)" >&2
