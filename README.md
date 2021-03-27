# Sample Python App Deployment on K8s using Helm

Application is written in python3 using the Flask Framework
Below Are the features. 
- Dump pages in any format
- Read the dumped pages

K8s Feautures used 

- Set Memory/CPU Limits .
- Pod Affinity .
- Horizontal Pod Autoscaling.
- Pod Disruption Budget
- Liveness probes


> **Note** : All the Pages are stored in a persitant volume enabling page retention 


## Deploying the App 
### Pre-requistes 
- Kubernetes Cluster (tested on `minikube version: v1.18.1`)
- Helm V2/V3
- Jenkins (to enable CI/CD)

### Additional Settings

Label the K8s node to ensure the pods gets scheduled on the specific node .
`kubectl label node <node-name> app=py`

> **Note:** Above label `app=py` is configured in the helm values.yaml .
> If you are setting a different value modify the values.yaml accordingly .

### Deploying using Helm

TO deploy the app run the below commands 

```
export ENV="production"
export CONFIG="<location to kubeconfig>"
helm install  --kubeconfig ${CONFIG} --wait --timeout 10 -f helmv2/${ENV}_values.yaml  -n ${ENV} ./helmv2
```

> **Note** : Available ENV options `staging, pre-prod & production` .
> values.yaml vary for each Environment 

### Configuring CICD on Jenkins

## Jenkins Pre-requistes 
Configure Jenkins Credentials 
- Configure Credential of kind **Secret file** with name `kubeconfig` and point it to kubeconfig
- Configure Credential of kind **Username with password** with name `DOCKER_HUB` and set docker hub credentials 

#### Configuring CI Pipeline for building Docker

To configure the CI Pipeline configure a pipeline Job  and set the Jenkinsfile avaiable in the below location

`CI/Jenkinsfile`

#### Configuring CD for deploying to K8s

To configure the CD Pipeline configure a pipeline Job  and set the Jenkinsfile avaiable in the below location

`CD/Jenkinsfile`