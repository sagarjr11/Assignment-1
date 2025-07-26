pipeline {
    agent any

    environment {
        GIT_REPO_URL = 'https://github.com/sagarjr11/Assignment-1.git'
        IMAGE_TAG = "v1.${BUILD_ID}"
        IMAGE_NAME = "node-js-app"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${GIT_REPO_URL}"
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('app') {
                    sh 'npm install'
                }
            }
        }

        stage('Run Tests') {
            steps {
                dir('app') {
                    sh 'npm test'
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        def image = "${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                        def latest = "${DOCKER_USER}/${IMAGE_NAME}:latest"

                        sh """
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker build -t ${image} .
                            docker tag ${image} ${latest}
                            docker push ${image}
                            docker push ${latest}
                        """
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        def latest = "${DOCKER_USER}/${IMAGE_NAME}:latest"
                        sh """
                            chmod +x Deploy_script.sh
                            ./Deploy_script.sh ${latest}
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
}
