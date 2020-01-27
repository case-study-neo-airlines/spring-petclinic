pipeline {

  agent none
  
  stages {
    stage('Build-war') {
      agent {
        docker {
          image 'maven:3.6.3-jdk-14'
          args '-e INITIAL_ADMIN_USER -e INITIAL_ADMIN_PASSWORD --network=${LDOP_NETWORK_NAME}'
        }
      }
      steps {
        configFileProvider([configFile(fileId: 'nexus', variable: 'MAVEN_SETTINGS')]) {
          sh 'mvn -s $MAVEN_SETTINGS clean deploy -DskipTests=true -B'
        }
      }
    }
    stage('Build-img') {
      steps {
        println "Building Docker image"
      }
    }
    stage('dev-deployment') {
      steps {
        println "Deploying to Dev"
      }
    }
    stage('test-deployment') {
      steps {
        println "Deployingt o test"
      }
    }
  }
  
}
