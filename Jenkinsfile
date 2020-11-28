pipeline {
  agent {
    docker {
      args '-v /Users/hsilva/.m2:/root/.m2'
      image 'maven'
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