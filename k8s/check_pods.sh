#!/bin/bash

sleep $1

# wait for completion as background process - capture PID
kubectl wait deployment -n default $2 --for condition=Available=True --timeout=$3 & completion_pid=$!

# wait for failure as background process - capture PID
kubectl wait deployment -n default $2 --for condition=Available=False --timeout=$3 && exit 1 & failure_pid=$!

# capture exit code of the first subprocess to exit
wait -n $completion_pid $failure_pid

# store exit code in variable
exit_code=$?
if (( $exit_code == 0 )); then
  echo "Job completed"
else
  echo "Job failed with exit code ${exit_code}, exiting..."
fi
exit $exit_code

#result=$(kubectl wait deployment -n default $2 --for condition=Available=True --timeout=$3 2>&1 >/dev/null)
#echo "Check 1 result: $result"
#
#result=$(kubectl wait deployment -n default $2 --for condition=Available=False --timeout=$3 2>&1 >/dev/null)
#echo "Check 2 result: $result"
#
#if echo $result | grep -q 'error'; then
#    echo "Check result: $result"
#    exit_code=1
#    echo "Build failed with exit code ${exit_code}, exiting..."
#    #kubectl logs -l app=$2 --tail=100
#else
#    echo "Build completed"
#    exit_code=0
#fi
#exit $exit_code

