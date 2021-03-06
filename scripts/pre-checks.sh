#!/bin/bash
set -e

echo "Checking if Docker is UP"
docker info --format '{{json .ServerVersion}}'

echo "Checking if K8s is UP"
kubectl --kubeconfig ${CONFIG} cluster-info

echo "Resource Status in ${ENV}"
kubectl get --kubeconfig ${CONFIG} deploy,svc,pv,pvc,configmap  -n ${ENV}