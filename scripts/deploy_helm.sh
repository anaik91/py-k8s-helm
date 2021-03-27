#!/bin/bash
set -e
kubectl get pods --kubeconfig ${CONFIG} -n ${ENV}
if [ "$( helm ls  --output json | jq  '.Releases[] | select(.Name=="${ENV}")' | wc -l )" -gt 0 ] ; then
    echo "is Deployed"
    helm upgrade --kubeconfig ${CONFIG} -f helmv2/${ENV}_values.yaml  ${ENV} ./helmv2
else
    echo "Not Deployed"
    helm install  --kubeconfig ${CONFIG} --wait --timeout 10 -f helmv2/${ENV}_values.yaml  -n ${ENV} ./helmv2 
fi
helm ls