pipeline {

    agent any

    environment{
        GITHUB_ORG = 'ChezoHome'
        CONTAINER_REGISTRY = "ghcr.io/${GITHUB_ORG}/"
        ARTIFACT_ID = "readMavenPom().getArtifactId()"
        JAR_NAME = "${ARTIFACT_ID}-${BUILD_NUMBER}"
        IMAGE_NAME = "${CONTAINER_REGISTRY}${ARTIFACT_ID}"
    }

    stages{
        stage('Build app'){

        agent{
            docker{
                image "openjdk:17"
                reuseNode true
            }
        }

            steps{
                sh 'echo Performing Maven Build : ${ARTIFACT_ID}'
                sh './mvn -DjarName=${JAR_NAME} clean verify'
            }
        }

        stage('Build container'){
            steps{
               sh 'echo Building Container Image: ${IMAGE_NAME}'
            }
        }

        stage('Publish image'){
            steps{
                sh 'echo Publishing container image to: ${CONTAINER_REGISTRY}'
            }
        }
    }
}