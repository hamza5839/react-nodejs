pipeline {
    agent any

    tools {
        // Ensure this name matches exactly what you set in Manage Jenkins -> Tools
        nodejs 'nodejs' 
    }

    stages {
        stage('build npm') {
            steps {
                script {
                    // Build the Backend
                    dir('api') {
                        sh 'npm install'
                    }
                    // Build the Frontend
                    dir('my-app') {
                        sh 'npm install'
                        // sh 'npm run build' // Uncomment if you need to build the React production files
                    }
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
        } // Closed the stage
    } // Closed the stages block
} // Closed the pipeline block
