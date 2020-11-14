pipeline {
  agent {
    docker {
      image 'maven'
    }

  }
  stages {
    stage('build') {
      steps {
        sh 'build.sh'
      }
    }

    stage('test') {
      steps {
        sh 'rest.sh'
      }
    }

    stage('deploy') {
      steps {
        sh 'deploy.sh'
      }
    }

  }
}