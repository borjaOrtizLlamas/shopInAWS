pipeline {
    agent any
    
    environment {
        variablesurl = ''
    }

	stages {
        stage('download proyect and variables - dev') {
            steps {
                git credentialsId: 'github_credential', url: 'https://github.com/borjaOrtizLlamas/shop_infraestucture_generator_vars.git'
            }
        }
        stage('Approve build') {
            steps {
                script {
                    if (env.BRANCH_NAME != 'master') {
                        env.variablesurl = 'develop'
                    } else {
                        env.variablesurl = 'master'
                    }
                    sh "export TF_LOG=DEBUG  && terraform init && terraform refresh -var-file=\"variables_${env.variablesurl}.tfvars\" && terraform plan -var-file=\"variables_${env.variablesurl}.tfvars\""
                    input(message : 'do you want to deploy this build to dev?')
                }
            }
        }

        stage('development enviorment execute') {
            steps {
                sh "export TF_LOG=DEBUG &&  terraform apply -input=false -auto-approve  -var-file=\"variables_${env.variablesurl}.tfvars\""
            }
        }

   }
}
