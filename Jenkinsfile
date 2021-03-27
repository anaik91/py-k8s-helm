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
                sh "kubectl get pods --kubeconfig $STAGING_CONFIG -n staging"
                sh "helm upgrade --install --kubeconfig $STAGING_CONFIG -f helmv2/staging_values.yaml  staging helmv2"
                sh "helm ls --kubeconfig $STAGING_CONFIG"
                sh "kubectl get pods --kubeconfig $STAGING_CONFIG -n staging"
            }
        }
        
        stage('PRE-PROD') {
            steps {
                echo 'PRE-PROD'
                sh "kubectl get pods --kubeconfig $PREPROD_CONFIG -n pre-prod"
                sh "helm upgrade --install --kubeconfig $PREPROD_CONFIG -f helmv2/preprod_values.yaml pre-prod helmv2"
                sh "helm ls --kubeconfig $PREPROD_CONFIG"
                sh "kubectl get pods --kubeconfig $STAGING_CONFIG -n staging"
            }
        }
        
        stage('PRODUCTION') {
            steps {
                echo 'PRODUCTION'
                sh "kubectl get pods --kubeconfig $PROD_CONFIG -n production"
                sh "helm upgrade --install --kubeconfig $PROD_CONFIG -f helmv2/prod_values.yaml production helmv2"
                sh "helm ls --kubeconfig $PROD_CONFIG"
                sh "kubectl get pods --kubeconfig $STAGING_CONFIG -n staging"
            }
        }
    }
}
