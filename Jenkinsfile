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
                // Add steps to run tests
                // e.g., sh 'vendor/bin/phpunit'
            }
        }
        stage('PHPCS') {
            steps {
                // Install PHP_CodeSniffer
                sh 'composer global require squizlabs/php_codesniffer'

                // Set PHPCS standards to WordPress
                sh 'phpcs --config-set installed_paths /path/to/wordpress-coding-standards'
                
                // Run PHPCS checks
                sh 'phpcs --standard=WordPress .'
            }
        }

        stage('Build Docker Image') {
            steps {
                        sh'docker build php/php-app:$BUILD_NUMBER .'
                    }
                }
            }
        }
        stage('Push Docker Image'){
            steps {
                script {withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIALS', variable: 'docker_hub_credentials_nebula')]) {
                        sh "docker login -u username -p $DOCKER_HUB_CREDENTIALS"
                    }
                        sh 'docker push php/php-app:$BUILD_NUMBER'
                 }
             }
        }

        stage('Cleaning up') {
            steps {
        sh "docker rmi php/php-app:$BUILD_NUMBER"
            }
        }
    
        
        stage('Deploy TO STAGING ENVIRONMENT') {
            steps {
                
                // Deploy to Docker Swarm 
                sh 'sed -i 's/your-image/php/php-app:$BUILD_NUMBER/g' docker-compose.yml'
                sh 'docker stack deploy -c docker-compose.yml php'
            }
        }
    }
}
