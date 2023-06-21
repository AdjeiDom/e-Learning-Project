
pipeline {
    agent any
    environment {
        TF_VERSION = '1.4.6'
        TF_CLI_ARGS = "-input=false"
        AWS_DEFAULT_REGION = 'us-west-1'
        DEV_DEPLOYMENT = 'dev'
        TEST_DEPLOYMENT = 'test'
        STAGE_DEPLOYMENT = 'stage'
        PROD_DEPLOYMENT = 'prod'        
    }
    tools {
        terraform "${env.TF_VERSION}"
    }
    stages {
        stage('Checkout') {
            steps {
               checkout([$class: 'GitSCM', branches: [[name:'*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/AdjeiDom/CloudRock-Consulting-Ltd-Dominic.git']]])
                }
            }
        
        stage('Build') {
            steps {
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform plan -out=terraform.plan'
            }
        }
        stage('Test Deployment') {
            steps {
                sh 'terraform apply -auto-approve -var-file=test.tfvars'
                sh 'curl http://test.betheldom-cloud-academy.click:80'
                sh 'terraform destroy -auto-approve'
            }
        }

        stage('Stage Deployment') {
            when {
                branch 'main'
            }
            steps {
                sh "terraform workspace new ${STAGE_DEPLOYMENT} || true"
                sh "terraform workspace select ${STAGE_DEPLOYMENT}"
                sh 'terraform apply -auto-approve -var-file=stage.tfvars'
                sh 'curl http://stage.betheldom-cloud-academy.click:80'
            }
        }
        stage('Prod Deployment') {
            when {
                branch 'master'
            }
            steps {
               sh "terraform workspace new ${PROD_DEPLOYMENT} || true"
               sh "terraform workspace select ${PROD_DEPLOYMENT}"
               sh 'terraform apply -auto-approve -var-file=prod.tfvars'
               }
            }
           
        }
    post {
            always {
                 sh 'terraform destroy -auto-approve'
            }
        }    
}


/* 
 stage ("terraform init") {
           steps {
              sh ('terraform init')
           }
        }
        stage ("terraform Action") {
            steps {
               echo "Terraform action is --> ${action}"
               sh ('terraform ${action} --auto-approve')
            }
        } */









