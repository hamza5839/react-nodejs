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
                    sh 'docker build -t react-app:1.3 .'
                }
            }
        }

        stage('push to dockerhub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                        sh 'docker tag react-app:1.3 $DOCKERHUB_USERNAME/react-app:1.3'
                        sh 'docker push $DOCKERHUB_USERNAME/react-app:1.3'
                    } // Ensure you have the 'dockerhub' credentials set up in Jenkins with your Docker Hub username and password
                } // Closed the script block
            } // Closed the steps block
        } // Closed the stage
        stage('deploy') {
            steps {
                script {
                    echo 'Deploying the application...'
                    sshagent(['ec2-server-key']) {
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.239.128.108 "docker run -d -p 3000:80 $DOCKERHUB_USERNAME/react-app:1.3"'
                    } // Ensure you have the 'ec2-server-key' credentials set up in Jenkins with your EC2 server's SSH private key
                }
            }
        }
    } // Closed the stages block
} // Closed the pipeline block
