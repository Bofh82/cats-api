#!/bin/bash

# wait for completion as background process - capture PID
#kubectl wait pods -l app=$1 --for=condition=Ready --timeout=60s & completion_pid=$!
#kubectl wait deployment/$1 --for=condition=Ready --timeout=60s & completion_pid=$!
kubectl wait deployment -n default $1 --for condition=Available=True --timeout=60s & completion_pid=$!

# wait for failure as background process - capture PID
#kubectl wait pods -l app=$1 --for=condition=Ready=false --timeout=60s && exit 1 & failure_pid=$!
#kubectl wait deployment/$1 --for=condition=Ready --timeout=60s && exit 1 & failure_pid=$!
kubectl wait deployment -n default $1 --for condition=Available=False --timeout=60s && exit 1 & failure_pid=$!

# capture exit code of the first subprocess to exit
wait -n $completion_pid $failure_pid

# store exit code in variable
exit_code=$?
if (( $exit_code == 0 )); then
  echo "Job completed"
else
  echo "Job failed with exit code ${exit_code}, exiting..."
  kubectl logs -l app=$1 --tail=100
fi
exit $exit_code
