pipeline{
    agent any

    environment{
        IMAGE_NAME='prinzkay/calendar:1'
    }

    stages{

        stage('Clear working directory'){
            steps{
                delDir()
            }
        }
    }

        stage('Checkout github repo'){
            steps{
                git branch: 'main', url: 'https://github.com/KamzyPrinzel/Calendar.git'
            }
        }   

        stage('Build Docker image'){
            steps{
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Scan Docker Image with trivy'){
            steps{
                sh 'trivy $IMAGE_NAME > calendar-1-result.txt'
            }
        }

        stage('Push to dockerhub'){
            steps{
                withCredentials([string(credentialsID:'dockerhub-password', variable: 'DOCKER_PASS')]){
                    sh  '''
                        echo 'DOCKER_PASS | docker login -u prinzkay --password-stdin
                        docker push $IMAGE_NAME
                        '''
                }
            }
        }
}    
