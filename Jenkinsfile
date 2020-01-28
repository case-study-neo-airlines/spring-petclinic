def project = 'neoairlines'
def  appName = 'petclinic'
def  imageTag = "gcr.io/${project}/${appName}:${env.BUILD_NUMBER}"


podTemplate(containers: [
  containerTemplate(name: 'maven', image: 'maven:3.3.9-jdk-8-alpine', ttyEnabled: true, command: 'cat'),
  containerTemplate(name: 'gcloud', image: 'gcr.io/cloud-builders/gcloud', ttyEnabled: true, command: 'cat'),
  containerTemplate(name: 'helm', image: 'kiwigrid/gcloud-kubectl-helm', ttyEnabled: true, command: 'cat')
  ]) {

  node(POD_LABEL) {
    stage('Check out source code') {
      checkout scm
    }
    
    stage('Build a Maven project') {
      container('maven') {
           sh 'mvn  clean install -DskipTests'   
           sh 'ls -ltr target/*.jar' 
      }
    }
    
    stage('Build a Docker image project') {
      container('gcloud') {
          sh 'ls -ltr target/*.jar' 
          sh """gcloud auth activate-service-account  neoowner@neoairlines.iam.gserviceaccount.com --key-file neoairlines-30baa3cf30d8.json \
          && gcloud config set project neoairlines && gcloud builds submit -t ${imageTag} ."""
      }
    }
    
    
    stage('Deploy to dev') {
      container('gcloud') {
          sh 'ls -ltr target/*.jar' 
          sh """gcloud auth activate-service-account  neoowner@neoairlines.iam.gserviceaccount.com --key-file neoairlines-30baa3cf30d8.json \
          && gcloud components install kubectl && gcloud container clusters get-credentials my-gke-cluster --region us-central1 --project neoairlines &&\
          gcloud config set project neoairlines && kubectl create deployment hello-web --image=${imageTag} -n dev"""
      }
    }
    
  }
}
