pipeline {
  agent any
  stages {
    stage('Lint') {
      steps {
        sh './bin/check_master.sh'
        sh './bin/lint.sh'
      }
    }
    stage('Plan') {
      steps {
        sh './bin/plan.sh'
      }
    }
    stage('Apply') {
      steps {
        sh './bin/apply.sh'
      }
    }
  }
}