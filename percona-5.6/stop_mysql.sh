#!/bin/bash

BINARY=${BINARY:-mysqld}
TIMEOUT=${TIMEOUT:-30}

echo -n "Terminating all processes with name: '$BINARY'"

PIDS=$(pgrep $BINARY -d ' ' --signal=SIGTERM)

if [ "$PIDS" = "" ]; then
    echo "No process found with name: '$BINARY' "
    exit 1
fi
echo -n " ($PIDS)"

for i in $(seq 1 $TIMEOUT); do
    if [ "$(kill -0 $PIDS 2>/dev/null; echo $?)" = 1 ]; then
        break
    fi
    
    sleep 1

    kill -SIGTERM $PIDS 2>/dev/null 
    echo -n '.'
done

kill -SIGKILL $PIDS 2>/dev/null

wait -n $PIDS 

echo ".done"
