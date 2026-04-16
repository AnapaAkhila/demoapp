pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/AnapaAkhila/demoapp.git'

        JFROG_URL = 'https://trialwcx5g6.jfrog.io/artifactory'
        JFROG_CREDS = credentials('jfrog-creds')

        MAVEN_REPO = 'Maven-repo'
        IMAGE_NAME = 'trialwcx5g6.jfrog.io/docker-repo/demoapp'

        APP_NAME = 'demoapp'
        PORT = '8081'
    }

    stages {

        stage('Clone') {
            steps {
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Upload WAR') {
            steps {
                sh """
                curl -u $JFROG_CREDS_USR:$JFROG_CREDS_PSW \
                -T target/${APP_NAME}.war \
                ${JFROG_URL}/${MAVEN_REPO}/${APP_NAME}-${BUILD_NUMBER}.war
                """
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .'
            }
        }

        stage('Docker Push') {
            steps {
                sh '''
                docker login -u $JFROG_CREDS_USR -p $JFROG_CREDS_PSW trialwcx5g6.jfrog.io
                docker push ${IMAGE_NAME}:${BUILD_NUMBER}
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker rm -f demoapp || true
                docker run -d -p 8081:8080 --name demoapp ${IMAGE_NAME}:${BUILD_NUMBER}
                '''
            }
        }
    }
}
