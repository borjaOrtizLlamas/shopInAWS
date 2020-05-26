pipeline {
   agent any
   tools {
      // Install the Maven version configured as "M3" and add it to the path.
      maven "M3"
   }
	stages {
        stage('download proyect and variables - dev') {
            steps {
                 dir('shop-proyect-dev') {
                    git credentialsId: 'github_credential', url: 'https://github.com/borjaOrtizLlamas/shopInAWS.git'
                 }
            }
        }
       
        stage('development enviorment execute') {
            steps {
                sh "cd shop-proyect-dev && terraform init"
                sh "cd shop-proyect-dev && terraform apply -input=false -auto-approve  -var-file=\"../variables_dev.tfvars\""
            }
        }
        stage('Approve build in production') {
            steps {
                input(message : 'do you want to deploy this build to production')
            } 
        }

        stage('download proyect and variables - PRO') {
            steps {
                 dir('shop-proyect-pro') {
                    git credentialsId: 'github_credential', url: 'https://github.com/borjaOrtizLlamas/shopInAWS.git'
                 }
            } 
        }

        stage('PRODUCTION enviorment execute') {
            steps {
                sh "cd shop-proyect-pro && terraform init"
                sh "cd shop-proyect-pro && terraform apply -input=false -auto-approve  -var-file=\"../variables_pro.tfvars\""
            } 
        }
   }
}
