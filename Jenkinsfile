pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout code from Git SCM
                git 'https://github.com/your/repository.git'
            }
        }


        
        stage('Testing') {
            steps {
                // Run tests
                sh 'go test ./...'
            }
        }
        
        stage('Linting') {
            steps {
                
                // Run GolangCI-Lint
                sh 'golangci-lint run'
            }
        }

        stage('Build Docker Image') {
            steps {
                        sh'docker build GO/GO-app:$BUILD_NUMBER .'
                    }
                }
            }
        }
        stage('Push Docker Image'){
            steps {
                script {withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIALS', variable: 'docker_hub_credentials_nebula')]) {
                        sh "docker login -u username -p $DOCKER_HUB_CREDENTIALS"
                    }
                        sh 'docker push GO/GO-app:$BUILD_NUMBER'
                 }
             }
        }

        stage('Cleaning up') {
            steps {
        sh "docker rmi GO/GO-app:$BUILD_NUMBER"
            }
        }
    
        
        stage('Deploy TO STAGING ENVIRONMENT') {
            steps {
                
                // Deploy to Docker Swarm 
                sh'sed -i 's/your-image-name/GO/GO-app:$BUILD_NUMBER/g' docker-compose.yml'
                sh 'docker stack deploy -c docker-compose.yml go'
            }
        }
    }
}
