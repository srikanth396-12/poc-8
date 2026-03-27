pipeline {
    agent any
 
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/srikanth396-12/poc-2.git'
            }
        }
 
        stage('Build Image') {
            steps {
                sh 'docker build -t java-poc:v1 .'
            }
        }
 
        stage('Test Inside Container') {
            steps {
                sh '''
                docker run --rm java-poc:v1 sh -c "java Hello | grep 'WebHook Works test'"
                '''
            }
        }
 
        stage('Deploy') {
            steps {
                sh '''
                docker rm -f java-poc-container || true
                docker run -d --name java-poc-container java-poc:v1
                '''
            }
        }
    }
}
