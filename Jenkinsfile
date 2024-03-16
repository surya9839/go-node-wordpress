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
                sh 'npm test'
            }
        }
        
        stage('PHPCS Check') {
            steps {
                sh 'composer install' 
                sh 'phpcs --standard=WordPress ./' // Run PHPCS with WordPress standards
            }
        }

        stage('Build Docker Image') {
            steps {
                        sh'docker build node/node-app:$BUILD_NUMBER .'
                    }
                }
            }
        }
        stage('Push Docker Image'){
            steps {
                script {withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIALS', variable: 'docker_hub_credentials_nebula')]) {
                        sh "docker login -u username -p $DOCKER_HUB_CREDENTIALS"
                    }
                        sh 'docker push node/node-app:$BUILD_NUMBER'
                 }
             }
        }

        stage('Cleaning up') {
            steps {
        sh "docker rmi node/node-app:$BUILD_NUMBER"
            }
        }
    
        
        stage('Deploy TO STAGING ENVIRONMENT') {
            steps {
                
                // Deploy to Docker Swarm 
                sh 'sed -i 's/your_nextjs_image:latest/node/node-app:$BUILD_NUMBER/g' docker-compose.yml'
                sh 'docker stack deploy -c docker-compose.yml node'
            }
        }
    }
}
