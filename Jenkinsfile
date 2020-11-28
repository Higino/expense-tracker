pipeline {
  agent {
    docker {
      image 'maven:3.3.9-jdk8'
      args '-v /Users/hsilva/.m2:/root/.m2'
    }

  }
  stages {
    stage('Initialize') {
      steps {
        sh '''echo PATH = ${PATH}
echo M2_HOME = ${M2_HOME}
mvn clean'''
      }
    }

  }
}