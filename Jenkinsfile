pipeline {
    agent any
    stages {
        stage('Building Docker Image') {
            steps {
                script {
                    // Docker handles the 'npm install' inside the container
                    sh 'docker build -t react-app:latest .'
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                        sh "docker tag react-app:latest ${DOCKERHUB_USERNAME}/react-app:latest"
                        sh "docker push ${DOCKERHUB_USERNAME}/react-app:latest"
                    }
                }
            }
        }
    }
}
