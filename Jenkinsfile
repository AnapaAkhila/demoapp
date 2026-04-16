pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/AnapaAkhila/demoapp.git'

        JFROG_URL = 'https://trialwcx5g6.jfrog.io/artifactory'
        JFROG_CREDS = credentials('jfrog-creds')

        MAVEN_REPO = 'Maven-repo'
        APP_NAME = 'demoapp'

        TOMCAT_PATH = '/opt/tomcat/webapps'
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
	stage('Deploy to Tomcat') {
    	   steps {
               sh """
               rm -rf ${TOMCAT_PATH}/${APP_NAME}*
               cp target/${APP_NAME}.war ${TOMCAT_PATH}/
                """
              }
         }
    }
    
}
