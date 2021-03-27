#!/bin/bash
kubectl get pods --kubeconfig $STAGING_CONFIG -n staging
if [ "$( helm ls  --output json | jq  '.Releases[] | select(.Name=="staging")' | wc -l )" -gt 0 ] ; then
    echo "is Deployed"
    helm upgrade --kubeconfig $STAGING_CONFIG -f helmv2/staging_values.yaml  staging ./helmv2
else
    echo "Not Deployed"
    helm install  --kubeconfig $STAGING_CONFIG -f helmv2/staging_values.yaml  -n staging ./helmv2 
fi
helm ls
kubectl get pods --kubeconfig $STAGING_CONFIG -n staging

kubectl get pods --kubeconfig $PREPROD_CONFIG -n pre-prod
if [ "$( helm ls  --output json | jq  '.Releases[] | select(.Name=="pre-prod")' | wc -l )" -gt 0 ] ; then
    echo "is Deployed"
    helm upgrade --kubeconfig $PREPROD_CONFIG -f helmv2/preprod_values.yaml  pre-prod ./helmv2
else
    echo "Not Deployed"
    helm install  --kubeconfig $PREPROD_CONFIG -f helmv2/preprod_values.yaml  -n pre-prod ./helmv2 
fi
helm ls
kubectl get pods --kubeconfig $PREPROD_CONFIG -n pre-prod


kubectl get pods --kubeconfig $PROD_CONFIG -n production
if [ "$( helm ls  --output json | jq  '.Releases[] | select(.Name=="production")' | wc -l )" -gt 0 ] ; then
    echo "is Deployed"
    helm upgrade --kubeconfig $PROD_CONFIG -f helmv2/prod_values.yaml  production ./helmv2
else
    echo "Not Deployed"
    helm install  --kubeconfig $PROD_CONFIG -f helmv2/prod_values.yaml  -n production ./helmv2 
fi
helm ls
kubectl get pods --kubeconfig $PROD_CONFIG -n production