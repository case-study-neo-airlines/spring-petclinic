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
           sh 'mv target/*.jar petclinic.jar' 
      }
    }
    
    stage('Build a Docker image project') {
      container('gcloud') {
          sh """gcloud auth activate-service-account  neoowner@neoairlines.iam.gserviceaccount.com --key-file neoairlines-30baa3cf30d8.json \
          && gcloud config set project neoairlines && gcloud builds submit -t ${imageTag} ."""
      }
    }
    
    stage('Deploy to dev') {
      container('gcloud') {
          sh """gcloud auth activate-service-account  neoowner@neoairlines.iam.gserviceaccount.com --key-file neoairlines-30baa3cf30d8.json \
          && gcloud components install kubectl && gcloud container clusters get-credentials my-gke-cluster --region us-central1 --project neoairlines &&\
          gcloud config set project neoairlines && kubectl create deployment petclinic-${env.BUILD_NUMBER} --image=${imageTag} -n dev && \
          kubectl expose deployment petclinic-${env.BUILD_NUMBER} --port 8080 --type=LoadBalancer --name=petclinic-${env.BUILD_NUMBER} -n dev"""
      }
    }
    
  }
}
