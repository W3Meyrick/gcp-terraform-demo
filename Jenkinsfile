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
        sh 'chown jenkins:jenkins bin/*'
        sh 'chmod 0770 bin/*'
        sh 'bin/check_master.sh'
        sh 'bin/lint.sh'
        sh 'gcloud auth activate-service-account terraform@rs-tf-sandbox.iam.gserviceaccount.com --key-file=/opt/terraform/key.json --project=rs-tf-sandbox'
        sh 'bin/plan.sh'
      }
    }

    stage('Plan') {
      when {
        changeRequest target: 'master'
      }
      steps {
        sh 'chown jenkins:jenkins bin/*'
        sh 'chmod 0770 bin/*'
        sh 'gcloud auth activate-service-account terraform@rs-tf-sandbox.iam.gserviceaccount.com --key-file=/opt/terraform/key.json --project=rs-tf-sandbox'
        sh 'bin/plan.sh'
      }
    }

    stage('Apply') {
      when {
        branch 'master'
      }
      steps {
        sh 'chown jenkins:jenkins bin/*'
        sh 'chmod 0770 bin/*'
        sh 'gcloud auth activate-service-account terraform@rs-tf-sandbox.iam.gserviceaccount.com --key-file=/opt/terraform/key.json --project=rs-tf-sandbox'
        sh 'bin/apply.sh'
      }
      
    }
  }
}