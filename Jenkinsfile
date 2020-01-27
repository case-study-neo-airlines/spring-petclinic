podTemplate(containers: [
  containerTemplate(name: 'maven', image: 'maven:3.3.9-jdk-8-alpine', ttyEnabled: true, command: 'cat')
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
    stage('Build Docker image') {
      sh "docker build -t test:1.0.0 ."
    }
  }
}
