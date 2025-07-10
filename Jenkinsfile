pipeline {
    agent any

    environment {
        IMAGE_NAME = "prinzkay/calendar:1"
    }

    stages {
        stage('Checkout GitHub repo') {
            steps {
                git branch:'main', url: 'https://github.com/KamzyPrinzel/Calendar.git'
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Scan Docker image with Trivy') {
            steps {
                script {
                    sh 'trivy image $IMAGE_NAME || true'  // use `|| true` to prevent pipeline fail on scan issues
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh """
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push $IMAGE_NAME
                    """
                }
            }
        }
    }
}
