#!/bin/bash
set -e -x
kubectl get pods --kubeconfig ${CONFIG} -n ${ENV}
if [ "$( helm ls  --output json | jq --arg env "$ENV" '.Releases[] | select(.Name==$env)' | wc -l )" -gt 0 ] ; then
    echo "is Deployed"
    helm del --purge ${ENV} 
else
    echo "Not Deployed. Skipping"
    
fi
helm ls