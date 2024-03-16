pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout code from Git SCM
                git branch: 'NODE', url: 'https://github.com/surya9839/go-node-wordpress.git' // Example
            }
        }

    stage('Linting and Formatting') {
            steps {
                // Install ESLint and Prettier
                sh 'npm install --save-dev eslint prettier eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser'
                
                // Run ESLint and Prettier
                sh 'npx eslint . --ext .js,.jsx,.ts,.tsx --fix'
                sh 'npx prettier --write .'
            }
        }
        
        stage('Testing') {
            steps {
                // Run your tests
                sh 'npm test'
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
