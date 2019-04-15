pipeline {
  agent any
  stages {
    stage('Lint') {
      when {
        changeRequest target: 'master'
      }
      steps {
        sh 'chmod 0777 /bin/*'
        sh './bin/lint.sh'
        sh './bin/check_master.sh'
        sh './bin/lint.sh'
      }
    }
    stage('Plan') {
      when {
        changeRequest target: 'master'
      }
      steps {
        sh './bin/plan.sh'
      }
    }
    stage('Apply') {
      when {
        branch 'master'
      }
      steps {
        sh './bin/apply.sh'
      }
    }
  }
}