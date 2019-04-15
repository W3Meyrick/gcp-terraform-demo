pipeline {
  agent any
  environment {
    PATH = "/opt/terraform/:$PATH"
  }
  stages {
    stage('Lint') {
      when {
        changeRequest target: 'master'
      }
      steps {
        sh 'export PATH=/opt/terraform:$PATH'
        sh 'chmod 0777 bin/*'
        sh 'bin/lint.sh'
        sh 'bin/check_master.sh'
        sh 'bin/lint.sh'
      }
    }
    stage('Plan') {
      when {
        changeRequest target: 'master'
      }
      steps {
        sh 'bin/plan.sh'
      }
    }
    stage('Apply') {
      when {
        branch 'master'
      }
      steps {
        sh 'bin/apply.sh'
      }
    }
  }
}