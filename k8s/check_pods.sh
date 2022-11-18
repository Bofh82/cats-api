#!/bin/bash

sleep $1

result=$(kubectl wait deployment -n default $2 --for condition=Available=True --timeout=$3 >&1 >/dev/null)
echo "Check 1 result: $result"

result=$(kubectl wait deployment -n default $2 --for condition=Available=False --timeout=$3 >&1 >/dev/null)
echo "Check 2 result: $result"

if echo $result | grep -q 'error'; then
    echo "Check result: $result"
    exit_code=1
    echo "Build failed with exit code ${exit_code}, exiting..."
    #kubectl logs -l app=$2 --tail=100
else
    echo "Build completed"
    exit_code=0
fi
exit $exit_code

