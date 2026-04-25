pipeline {
    agent any
    tools {
        nodejs 'nodejs' // Define any tools you need here, e.g., JDK, Maven, etc.
        }
        stages {
            stage('build npm') {
                steps {
                    script {
                        sh 'npm install'
                    }
                }
            }
            stage('building image') {
                steps {
                    script {
                        sh 'docker build -t react-app:latest .'
                    }
                }
            }
            stage('push to dockerhub') {
                steps {
                    script {
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                            sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                            sh 'docker tag react-app:latest $DOCKERHUB_USERNAME/react-app:latest'
                            sh 'docker push $DOCKERHUB_USERNAME/react-app:latest'
                        }
                    }
                }
        }        
}
