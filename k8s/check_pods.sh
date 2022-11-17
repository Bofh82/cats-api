#!/bin/bash

sleep 120s

result=$(kubectl wait deployment -n default $1 --for=condition=Ready --timeout=90s 2>&1 >/dev/null)
#result=$(kubectl rollout status deployment $1 -n default --timeout=90s 2>&1 >/dev/null)

echo "Check result: $result"

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

