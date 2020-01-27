def project = 'REPLACE_WITH_YOUR_PROJECT_ID'
def  appName = 'gceme'
def  feSvcName = "${appName}-frontend"
def  imageTag = "gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"


podTemplate(containers: [
  containerTemplate(name: 'maven', image: 'maven:3.3.9-jdk-8-alpine', ttyEnabled: true, command: 'cat'),
  containerTemplate(name: 'gcloud', image: 'gcr.io/cloud-builders/gcloud', ttyEnabled: true, command: 'cat')
  ]) {

  node(POD_LABEL) {
    stage('Check out source code') {
      checkout scm
    }
    stage('Build a Maven project') {
      container('maven') {
          sh 'mvn  clean install -DskipTest'   
      }
    }
    
    stage('Build a Docker image project') {
      container('gcloud') {
          sh "PYTHONUNBUFFERED=1 gcloud builds submit -t ${imageTag} ."
      }
    }
  }
}
