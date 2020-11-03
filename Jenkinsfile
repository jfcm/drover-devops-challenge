#!/usr/bin/env groovy

// Pipeline stage naming constants
ENVIRONMENT_SETUP_STAGE = 'Environment Setup'
BUILD_STAGE = 'Build'
UNIT_TEST_STAGE = 'Unit Test'
DEPLOY_STAGE = 'Deploy'

// Build result constants
SUCCESS_RESULT = 'SUCCESS'
NOT_BUILT_RESULT = 'NOT_BUILT'
ABORTED_RESULT = 'ABORTED'
FAILURE_RESULT = 'FAILURE'

// Project constants
PROJECT_NAME = 'DROVE_APP'
APP_DIR = 'drover-app'
DEPLOYMENT_DIR = 'terraform'

// Configuration defaults
currentBuild.result = SUCCESS_RESULT

// Pipeline steps
try {

    node("master") {
        stage(ENVIRONMENT_SETUP_STAGE) {
            envSetup()
            echo '[Jenkinsfile] Environment Setup stage done.'
        }
    
        stage(BUILD_STAGE){
            build()
            echo '[Jenkinsfile] Build stage done.'
        }
    
        stage(UNIT_TEST_STAGE) {
            unitTest()
            echo '[Jenkinsfile] Unit Test stage done.'
        }

        stage(DEPLOY_STAGE) {
            deploy()
            echo '[Jenkinsfile] Deploy stage done.'
        }
    }
} catch (err) {
    echo "Exception caught: ${err.toString()}"
    currentBuild.result = FAILURE_RESULT
}

def envSetup() {
    deleteDir()     // delete jenkins working dir
    checkout scm    // clones the git repository
}

def build() {
    echo '[Jenkinsfile] Building Drover Application.'
    dir("${APP_DIR}") {
        sh """
            ./mvnw clean install -DskipTests
        """
    }
}

def unitTest() {
    echo '[Jenkinsfile] Testing Drover Application.'
    dir("${APP_DIR}") {
        sh """
            ./mvnw test
        """
    }
}

def deploy() {
    echo '[Jenkinsfile] Deploying Drover Application using Terraform and Docker.'
    dir("${DEPLOYMENT_DIR}") {
        sh """
            terraform init
            terraform plan
            terraform apply -auto-approve
        """
    }
}