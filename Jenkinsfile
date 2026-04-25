pipeline {
    agent any
    tools {
        maven 'maven-3.9'
        }
        stages {
            stage('building Jar') {
                steps {
                    script {
                        sh 'mvn clean package -DskipTests'
                    }
                }
            stage('building image') {
                steps {
                    script {
                        sh 'docker build -t myapp:latest .'
                    }
                }
            }
            stage('push to dockerhub') {
                steps {
                    script {
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                            sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                            sh 'docker tag myapp:latest $DOCKERHUB_USERNAME/myapp:latest'
                            sh 'docker push $DOCKERHUB_USERNAME/myapp:latest'
                        }
                    }
                }
        }
        
}
