pipeline {
    agent any

    environment {
        IMAGE_NAME = "prinzkay/calendar:1"
    }

    stages {

        stage('Checkout GitHub repo') {
            steps {
                sh 'git config --global --add safe.directory $WORKSPACE'
                git branch: 'main', url: 'https://github.com/KamzyPrinzel/Calendar.git'
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Scan Docker image with Trivy') {
            steps {
                script {
                   sh "trivy image --exit-code 1 --severity CRITICAL ${IMAGE_NAME}"
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                            echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin
                            docker push ${IMAGE_NAME}
                        """
                    }
                }
            }
        }
    }
}
