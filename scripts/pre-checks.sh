#!/bin/bash
set -e

echo "Checking if Docker is UP"
docker info --format '{{json .ServerVersion}}'

echo "Checking if K8s is UP"
kubectl cluster-info

echo "Resource Status in ${ENV}"
kubectl get deploy,svc,pv,pvc,configmap -n ${ENV}