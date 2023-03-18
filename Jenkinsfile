pipeline {

    agent any
    environment{
        GITHUB_ORG = 'ChezoHome'
        CONTAINER_REGISTRY = "ghcr.io/${GITHUB_ORG}/"
        CONTAINER_REGISTRY_URL="https://${CONTAINER_REGISTRY}"
        ARTIFACT_ID = "test"
        JAR_NAME = "${ARTIFACT_ID}-${BUILD_NUMBER}"
        JAR_LOCATION="target/${JAR_NAME}.jar"
        IMAGE_NAME = "${CONTAINER_REGISTRY}${ARTIFACT_ID}"
        IMAGE_TAG="${IMAGE_NAME}:${BUILD_NUMBER}"
    }

    stages{

        stage('Build app'){
        agent{
            docker{
                image "arm64v8/amazoncorretto:17"
                reuseNode true
            }
        }

            steps{
                sh 'echo Performing Maven Build : ${ARTIFACT_ID}'
                sh 'pwd'
                sh 'ls -al'
                sh 'chmod +x gradlew'
                sh './gradlew clean'
            }
        }

        stage('Build container'){
            steps{
               sh 'echo Building Container Image: ${IMAGE_NAME}'
               sh 'sh docker build --build-arg JAR_FILE=${JAR_LOCATION} -t ${IMAGE_TAG} .'
            }
        }

        stage('Publish image'){
            steps{
                sh 'echo Publishing container image to: ${CONTAINER_REGISTRY}'

                script{
                    docker.withRegistry("${CONTAINER_REGISTRY_URL}","github-pat"){
                        sh 'docker push ${IMAGE_TAG}'
                    }
                }
            }
        }
    }
}