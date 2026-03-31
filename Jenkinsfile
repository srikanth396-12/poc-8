pipeline {
    agent any
 
    tools {
        sonarScanner 'SonarScanner'
    }
 
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/srikanth396-12/poc-8.git'
            }
        }
 
        stage('Build Image') {
            steps {
                sh 'docker build -t java-poc:v1 .'
            }
        }
 
        stage('Test Inside Container') {
            steps {
                sh 'docker run --rm java-poc:v1 sh -c "java Hello | grep \\"WebHook Works test\\""'
            }
        }
 
        stage('Sonar Scan') {
            steps {
                withSonarQubeEnv('SonarCloud') {
                    withCredentials([string(credentialsId: 'sonartoken', variable: 'SONAR_TOKEN')]) {
                        sh '''
                        sonar-scanner \
                          -Dsonar.organization=srikanth396-12 \
                          -Dsonar.projectKey=srikanth396-12_poc-8 \
                          -Dsonar.sources=. \
                          -Dsonar.host.url=https://sonarcloud.io \
                          -Dsonar.token=$SONAR_TOKEN
                        '''
                    }
                }
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
