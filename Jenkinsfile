pipeline {
  agent any
  stages {
    stage('Initialize') {
      steps {
        sh '''cd ./expense-service
./mvnw clean'''
      }
    }

    stage('Build') {
      steps {
        sh '''./expense-service/mvw install
'''
      }
    }

  }
}