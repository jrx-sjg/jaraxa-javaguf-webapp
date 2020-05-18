@Library('devops-tools')
import org.netscale.jenkins.slack.SlackNotifier

pipeline {
  options {
      buildDiscarder(logRotator(numToKeepStr: '15'))
  }    
  agent {
    label "jenkins-maven-nodejs"
  }

  environment {
    SLACK_CHANNEL = 'lesroches-bots'
    SLACK_DOMAIN  = 'jaraxa'
    SLACK_CREDENTIALS = 'slack-netcomp-devops'  
    ORG = 'netscale-technologies'
    APP_NAME = 'absences-management'
    CHARTMUSEUM_CREDS = credentials('jenkins-x-chartmuseum')
    DOCKER_REGISTRY_ORG = 'netscale-technologies'
    NEXUS_CREDENTIAL_ID = credentials('nexus-credentials')
    PROMOTE_ENV_NAME = 'environment-sommet-develop'
    SPRING_PROFILES_ACTIVE = 'develop'
    REMOTE_ENV_NAME = 'jx-sommet-remote'
  }
  stages {
    stage('Pre-actions and notifications') {
      steps {
        script { 
          new SlackNotifier().notifyStart() 
        }
      }
    }
    /*
    stage('Wipe sessions on develop database') {
      when {
        branch 'develop'
      }
      environment {
        SPRING_PROFILES_ACTIVE = 'develop'
        MSSQL_DEVELOP_SERVER = 'sommet-mssql-mssql-linux.databases.svc.cluster.local'
        MSSQL_DEVELOP_PASS = credentials('mssql-devel-credentials')
        MSSQL_DB_NAME = "absences_develop"
      }
      steps {
        container('mssqlcli') {
            sh 'echo "DELETE FROM SPRING_SESSION;" > /tmp/sessions.sql'
            sh "cat /tmp/sessions.sql"
            sh "/opt/mssql-tools/bin/sqlcmd -S $MSSQL_DEVELOP_SERVER,1433 -U sa -P $MSSQL_DEVELOP_PASS -d $MSSQL_DB_NAME -i /tmp/sessions.sql"
        }
      } 
    }
    */
    stage('Build Develop Preview') {
      when {
        branch 'develop'
      }
      environment {
        SPRING_PROFILES_ACTIVE = 'develop'
        PREVIEW_VERSION = "0.1.0-SNAPSHOT-$BRANCH_NAME-$BUILD_NUMBER"
        PREVIEW_NAMESPACE = "jx-sommet-develop"
        HELM_RELEASE = "$PREVIEW_NAMESPACE".toLowerCase()
      }
      steps {
        container('mavennodejs') {
          // Maven - NPM Build
          sh "npm ci --prefer-offline --no-audit"
          sh "./node_modules/.bin/gulp release"
          sh "mvn clean deploy"          
          // Preview build
          sh "export VERSION=$PREVIEW_VERSION && skaffold build -f skaffold.yaml"
          sh "jx step post build --image $DOCKER_REGISTRY/$ORG/$APP_NAME:$PREVIEW_VERSION"
          dir('./charts/preview') {
            sh "make preview"
          }
          sh "jx step helm install charts/preview --namespace $PREVIEW_NAMESPACE --name $APP_NAME --dir ./charts/preview/ --verbose"                      
          sh "kubectl get ingress $APP_NAME-preview --namespace $PREVIEW_NAMESPACE -o jsonpath='{.spec.rules[*].host}' > ../../APP_URL"                        
        }
      }
    }
    stage('Build UAT/prod Release') {
      when {
        branch 'master'
      }
      steps {
        container('mavennodejs') {
          // ensure we're not on a detached head
          sh "git checkout master"
          sh "git config --global credential.helper store"
          sh "jx step git credentials"
          // so we can retrieve the version in later steps
          sh "echo \$(jx-release-version) > VERSION"
          sh "mvn versions:set -DnewVersion=\$(cat VERSION)"
          sh "jx step tag --version \$(cat VERSION)"
          // Maven - NPM Build          
          sh "npm ci --prefer-offline --no-audit"
          sh "./node_modules/.bin/gulp release"
          sh "mvn clean deploy"
          // Artifacts Build
          sh "skaffold version"
          sh "export VERSION=`cat VERSION` && skaffold build -f skaffold.yaml"
          sh "jx step post build --image $DOCKER_REGISTRY/$ORG/$APP_NAME:\$(cat VERSION)"
        }
      }
    }
    stage('Promote master to UAT/prod environment') {
      when {
        branch 'master'
      }
      environment {
        SPRING_PROFILES_ACTIVE = 'staging'
        REMOTE_ENV_NAME = 'jx-sommet-remote'
        STAGING_NAMESPACE = 'jx-sommet-staging'
      }
      steps {
        container('mavennodejs') {
          dir('charts/absences-management') {
            sh "jx step changelog --version v\$(cat ../../VERSION)"

            // release the helm chart
            sh "jx step helm release"

            // promote through the promotion environment
            sh "jx promote -b --timeout 1h --pull-request-poll-time 5s --version \$(cat ../../VERSION) --env $REMOTE_ENV_NAME"
            script {
              def VERSION = readFile "../../VERSION"              
              slackSend (channel: "$SLACK_CHANNEL", color: '#0066ff', message: "${env.JOB_NAME} version: ${VERSION} succesfully promoted ${env.BUILD_DISPLAY_NAME} :beers:")
            }
            // delete unnecessary staging namespace
            sh "jx delete namespace $STAGING_NAMESPACE --batch-mode -y"
          }
        }
      }
    } 
  }
  post {
        always {
          script {
            if (env.BRANCH_NAME == 'develop' && fileExists('APP_URL')) {
            env.WORKSPACE = pwd()
            def APP_URL = readFile "${env.WORKSPACE}/APP_URL"              
            new SlackNotifier().notifyResultFull()
            slackSend (channel: "$SLACK_CHANNEL", color: '#0066ff', message: "${env.JOB_NAME} preview URL available ><https://${APP_URL}|here>< ${env.BUILD_DISPLAY_NAME} :beers:")
            }              
            else {
            new SlackNotifier().notifyResultFull()
            }         
          }       
          archiveArtifacts artifacts: '**/*.jar', fingerprint: true
          cleanWs()
        }
  }
}
