pipeline {
    agent any

    tools {
        maven 'MVN_HOME'
    }

    environment {
        // Nexus details
        NEXUS_VERSION     = "nexus3"
        NEXUS_PROTOCOL    = "http"
        NEXUS_URL         = "44.206.236.146:8081"
        NEXUS_REPOSITORY  = "shaik-Repo"
        NEXUS_CREDENTIAL_ID = "nexus_keygen"

        // SonarQube scanner tool
        SCANNER_HOME = tool 'sonar_scanner'

        // Slack details
        SLACK_CHANNEL = "#jenkins-integration"
    }

    stages {
        stage("Clone Code") {
            steps {
                git branch: 'main', url: 'https://github.com/Shaik123-hu/Shaik-Repo.git'
            }
        }

        stage("Maven Build") {
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=true clean install'
            }
        }

        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv('sonarqube_server') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectKey=Shaik-Repo \
                        -Dsonar.projectName="Shaik-Repo" \
                        -Dsonar.projectVersion=1.0 \
                        -Dsonar.sources=src/main/java \
                        -Dsonar.java.binaries=target/classes '''
                }
            }
        }

        stage("Publish to Nexus") {
            steps {
                script {
                    pom = readMavenPom file: "pom.xml"
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}")
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path}"
                    artifactPath = filesByGlob[0].path
                    artifactExists = fileExists artifactPath

                    if (artifactExists) {
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: pom.artifactId, classifier: '', file: artifactPath, type: pom.packaging],
                                [artifactId: pom.artifactId, classifier: '', file: "pom.xml", type: "pom"]
                            ]
                        )
                    } else {
                        error "*** File: ${artifactPath}, could not be found"
                    }
                }
            }
        }

        stage("Deploy to Tomcat") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'tomcat', usernameVariable: 'TOMCAT_USER', passwordVariable: 'TOMCAT_PASS')]) {
                    script {
                        // WAR file built by Maven
                        def warFile = sh(script: "ls target/*.war | head -n 1", returnStdout: true).trim()

                        echo "Deploying ${warFile} to Tomcat at context path /sunil-app ..."

                        sh """
                            curl -u $TOMCAT_USER:$TOMCAT_PASS \
                                 -T ${warFile} \
                                 "http://52.23.219.234:8080/manager/text/deploy?path=/Shaik-Repo&update=true"
                        """
                    }
                }
            }
        }

        stage("Slack Notification") {
            steps {
                slackSend(
                    channel: "${SLACK_CHANNEL}",
                    color: "#36a64f",
                    message: "✅ Jenkins Declarative Pipeline for *Shaik Yunus* deployed successfully to Tomcat! Job: ${env.JOB_NAME} [${env.BUILD_NUMBER}]"
                )
            }
        }
    }
}
