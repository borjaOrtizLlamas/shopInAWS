def variablesDef = null

pipeline {
    agent any
    
	stages {
        stage('download proyect and variables - dev') {
            steps {
                dir('envs') {
                    git credentialsId: 'github_credential', url: 'https://github.com/borjaOrtizLlamas/shop_infraestucture_generator_vars.git'
                }
            }
        }
        stage('Approve build') {
            steps {
                script {
                    if (env.BRANCH_NAME != 'master') {
                        variablesDef = 'develop'
                    } else {
                        variablesDef = 'master'
                    }
                    sh "export TF_LOG=DEBUG  && terraform init && terraform refresh -var-file=\"envs/variables_${variablesDef}.tfvars\" && terraform plan -var-file=\"envs/variables_${variablesDef}.tfvars\""
                    input(message : 'do you want to deploy this build to dev?')
                }
            }
        }

        stage('development enviorment execute') {
            steps {
                sh "export TF_LOG=DEBUG &&  terraform apply -input=false -auto-approve  -var-file=\"envs/variables_${variablesDef}.tfvars\""
            }
        }

   }
}
