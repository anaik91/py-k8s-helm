pipeline {
    agent any

    environment {
        STAGING_CONFIG = credentials('kubeconfig')
        PREPROD_CONFIG = credentials('kubeconfig')
        PROD_CONFIG = credentials('kubeconfig')
    }

    stages {
        stage('STAGING') {
            steps {
                echo 'STAGING'
                sh "helm upgrade --install --kubeconfig $STAGING_CONFIG -n staging -f pyk8s/staging_values.yaml  staging pyk8s"
                sh "helm ls --kubeconfig $STAGING_CONFIG -n staging"
                sh "kubectl get pods --kubeconfig $STAGING_CONFIG -n staging"
            }
        }
        
        stage('PRE-PROD') {
            steps {
                echo 'PRE-PROD'
                sh "kubectl get pods --kubeconfig $PREPROD_CONFIG -n pre-prod"
                sh "helm upgrade --install --kubeconfig $PREPROD_CONFIG -n pre-prod -f pyk8s/preprod_values.yaml pre-prod pyk8s"
                sh "helm ls --kubeconfig $PREPROD_CONFIG -n pre-prod"
                sh "kubectl get pods --kubeconfig $STAGING_CONFIG -n staging"
            }
        }
        
        stage('PRODUCTION') {
            steps {
                echo 'PRODUCTION'
                sh "kubectl get pods --kubeconfig $PROD_CONFIG -n production"
                sh "helm upgrade --install --kubeconfig $PROD_CONFIG -n production -f pyk8s/prod_values.yaml production pyk8s"
                sh "helm ls --kubeconfig $PROD_CONFIG -n production"
                sh "kubectl get pods --kubeconfig $STAGING_CONFIG -n staging"
            }
        }
    }
}
