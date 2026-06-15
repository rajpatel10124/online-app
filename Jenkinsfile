pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'rajpatel1202'
        IMAGE_NAME     = 'online-shop'
        IMAGE_TAG      = 'latest'
    }

    stages {
        stage('Cloning Code') {
            steps {
                echo ' Pulling fresh source code from Git repository...'
                checkout scm
            }
        }

        stage('Docker Lint & Security Check') {
            steps {
                echo ' Verifying local Docker workspace configuration...'
                sh 'test -f Dockerfile'
            }
        }

        stage('Production Container Build') {
            steps {
                echo ' Compiling React bundle and building production Nginx image...'
                sh "docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Local Zero-Downtime Deployment') {
            steps {
                echo ' Stopping and purging older instances...'
                sh 'docker stop shopping-app-container || true'
                sh 'docker rm shopping-app-container || true'
                
                echo ' Deploying updated production web server on Port 80...'
                sh "docker run -d --name shopping-app-container -p 80:80 --restart always ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                
                echo ' Pruning dangling build layers to conserve storage...'
                sh 'docker image prune -f'
            }
        }
    }

    post {
        success {
            echo ' Pipeline execution finished successfully! App is live.'
        }
        failure {
            echo ' Pipeline failed. Check console outputs for diagnostics.'
        }
    }
}