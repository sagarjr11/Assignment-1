pipeline {
    agent any   //you can change name of your slave node and paste it here to run jobs on the node.

    environment {
        GIT_REPO_URL = 'https://github.com/yourusername/nodejs-ci-cd.git'
        DOCKERHUB_USERNAME = credentials('dockerhub-username')  // Jenkins credential (type: "Username")
        DOCKER_IMAGE = "${DOCKERHUB_USERNAME}/node-js-app"
        IMAGE_TAG = "v1.${BUILD_ID}"

    }

    stages {
        stage(' Git Checkout') {
            steps {
                git "${GIT_REPO_URL}"
            }
        }
        stage('Install Dependencies') {
            steps {
                dir('app') {
                    sh 'npm install'
                }
            }
        }
        stage('Run Unit Tests') {
            steps {
                dir('app') {
                    sh 'npm test'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                 sh '''
            docker build -t $DOCKER_IMAGE:$IMAGE_TAG .                #Tag: dockerhubusername/node-js-app:v1.45 Image Taging
            docker tag $DOCKER_IMAGE:$IMAGE_TAG $DOCKER_IMAGE:latest  #Tag: dockerhubusername/node-js-app:latest Final Tag
        ''
            }
        }
        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'chmod +x Deploy_script.sh && ./Deploy_script.sh'
            }
        }
    }
    post {
        success {
            echo ' Deployment Successful!'
        }
        failure {
            echo ' Deployment Failed!'
        }
    }
}
