pipeline {
    agent any
	stages {
        stage('download proyect and variables - dev') {
            steps {
                dir('shop-proyect-dev') {
                   git credentialsId: 'github_credential', url: 'https://github.com/borjaOrtizLlamas/shop_infraestucture_generator_vars.git'
                }
            }
        }
        stage('Approve build in dev') {
            steps {
                dir('shop-proyect-dev') {
                    sh "cp ../*.tf ./ && cp ../*.json ./"
                    sh "export TF_LOG=DEBUG  && terraform init && terraform refresh -var-file=\"variables_dev.tfvars\" && terraform plan -var-file=\"variables_dev.tfvars\""
                }
                input(message : 'do you want to deploy this build to dev?')
            }
        }

        stage('development enviorment execute') {
            steps {
                dir('shop-proyect-dev') {
                    sh "export TF_LOG=DEBUG &&  terraform apply -input=false -auto-approve  -var-file=\"variables_dev.tfvars\""
                }
            }
        }


        stage('download proyect and variables - PRO') {
            steps {
                 dir('shop-proyect-pro') {
                    git credentialsId: 'github_credential', url: 'https://github.com/borjaOrtizLlamas/shop_infraestucture_generator_vars.git'
                 }
            } 
        }
        
        
        stage('Approve build in production') {
            steps {
                if ($branch != 'master') {
                    currentBuild.result = 'ABORTED'
                    error('Stopping early…')
                }
                dir('shop-proyect-pro') {
                    sh "cp ../*.tf ./ && cp ../*.json ./"
                    sh "export TF_LOG=DEBUG && terraform init  && terraform refresh -var-file=\"variables_pro.tfvars\" && terraform plan -var-file=\"variables_pro.tfvars\""
                    input(message : 'do you want to deploy this build to production?')
                }
            }        
        }

        stage('PRODUCTION enviorment execute') {
            steps {
                dir('shop-proyect-pro') {
                    sh "export TF_LOG=DEBUG && terraform apply -input=false -auto-approve  -var-file=\"variables_pro.tfvars\""
                }
            }
        }
   }
}
