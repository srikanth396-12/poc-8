pipeline {
    agent any
 
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
                        export SONAR_SCANNER_VERSION=8.0.1.6346
                        export SONAR_SCANNER_HOME=$HOME/.sonar/sonar-scanner-$SONAR_SCANNER_VERSION-linux-x64
                        curl --create-dirs -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux-x64.zip
                        unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
                        export PATH=$SONAR_SCANNER_HOME/bin:$PATH
         
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
            docker run -d -p 8080:8080 --name java-poc-container java-poc:v1
            '''
        }
    }
    }
}
