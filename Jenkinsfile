

// In order to run this pipeline you need to configure your GCP personal credentials locally on jenkins master machine 


pipeline {
    agent any
    stages {
        stage('Clone Terraform Repository') {
            steps {
                git 'https://github.com/Alii2121/GCP_Iac_DevOps_Demo.git'
            }
        }
        stage('Terraform Init') {
            steps {
                  sh 'terraform init'  
                       
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
    post {
        always {
            sh 'terraform destroy -auto-approve'
        }
    }
}

