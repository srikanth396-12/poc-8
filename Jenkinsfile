pipeline {
    agent any
 
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/srikanth396-12/poc-2.git'
            }
        }
 
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t java-poc:v1 .'
            }
        }
 
        stage('Run Container') {
            steps {
                sh '''
                docker rm -f java-poc-container || true
                docker run --name java-poc-container java-poc:v1
                '''
            }
        }
    }
}
