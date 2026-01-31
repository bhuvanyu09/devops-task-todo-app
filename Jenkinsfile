pipeline {
    agent any
    environment {
        // "Mock" credentials 
        REGISTRY = 'my-dockerhub-username/todo-summary' 
        registryCredential = 'docker-hub-credentials'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Maven Build') {
            steps {
                // I pointed Maven to the correct folder we found earlier
                sh 'mvn -f Backend/todo-summary-assistant/pom.xml clean package'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    // This builds the image using the Dockerfile
                    dockerImage = docker.build(REGISTRY + ":${IMAGE_TAG}")
                }
            }
        }
        stage('Push Image') {
            steps {
                // In a real server, this would login using the credentials above
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
}