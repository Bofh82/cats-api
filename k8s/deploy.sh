#!/bin/bash

cat ./k8s/deployment.yaml |
sed -r "s/ENV_JOB_BASE_NAME/$1/g" |
sed -r "s/ENV_BUILD_NUMBER/$2/g;" |
sed -r "s/ENV_DATASOURCE_HOST/$3/g;" |
sed -r "s/ENV_DATASOURCE_PORT/\"$4\"/g;" |
sed -r "s/ENV_SERVICE_NAME/$5/g;" |
sed -r "s/ENV_SERVICE_PORT/\"$6\"/g;" |
kubectl apply -f -
