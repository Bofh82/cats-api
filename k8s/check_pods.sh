#!/bin/bash

sleep $1

result=$(kubectl wait deployment -n default $2 --for=condition=Ready --timeout=30s 2>&1 >/dev/null)

if echo $result | grep -q 'error'; then
    echo "Check result: $result"
    exit_code=1
    echo "Build failed with exit code ${exit_code}, exiting..."
    kubectl logs -l app=$1 --tail=100
else
    echo "Build completed"
    exit_code=0
fi
exit $exit_code

