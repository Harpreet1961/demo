def emailRecipients = "aparupmandal@gmail.com"
def fromAddress = "aparupmandal@gmail.com"
def inforeportDesc = "Info Notification Queue"
def errorreportDesc = "Error Notification Queue"
//def result=""

pipeline {    
   agent any
 
   environment {
    PATH = "/usr/local/bin/:/usr/bin:/usr/local/sbin:/usr/sbin"
    }
   stages {
   stage('SCM Checkout') {
        steps{
            dir('source-code')
            {
                git branch: "sqs",                
                url: 'git@github.com:Harpreet1961/demo.git'
            }  
          }
       }

   stage('List folder') {
        steps {
        sh " cd $WORKSPACE"
        sh " ls -lhrt"
        sh " ls -lhrt source-code"
        sh " chmod 777 -R source-code"
        }
    }

    stage('GatherData customer-alert-notification-stagging') {
        steps {
            script {
            //echo "Collecting the sqs queue size"
            def result = sh(script: "${env.WORKSPACE}/source-code/get_sqs_queue.sh customer-alert-notification-staging", returnStdout: true).trim()
            echo $result
             echo "res1 from script : ${result}"
            //def re1 = result.toLowerCase()
            
            if (( result =~ 'info' )) {
                echo "Send Info Email"
                sendEmail(inforeportDesc,emailRecipients)
            } else {
                echo "Send Error Email"
                sendEmail(errorreportDesc,emailRecipients)
            }
        }
    }
}
   stage('GatherData customer-alert-notification-dev') {
        steps {
            script {
            //echo "Collecting the sqs queue size"
            def result = sh(script: "${env.WORKSPACE}/source-code/get_sqs_queue.sh customer-alert-notification-dev", returnStdout: true).trim()
            echo "res2 from script : ${result}"
            //def re = result.toLowerCase()
            
            if (( result =~ 'info' )) {
                echo "Send Info Email"
                sendEmail(inforeportDesc,emailRecipients)
            } else {
                echo "Send Error Email"
                sendEmail(errorreportDesc,emailRecipients)
            }
        }
    }
}
}
}

void sendEmail(inforeportDesc,emailRecipients) {
        println 'Sending Email for sqs'
        emailext body: "<p>Hi All,<br /><br />Please check.<br /><br />Thanks<br />Team</p>", subject: "${inforeportDesc}", to: "${emailRecipients}"
    }

void sendEmail(errorreportDesc,emailRecipients) {
        println 'Sending Email for sqs'
        emailext body: "<p>Hi All,<br /><br />Please check.<br /><br />Thanks<br />Team</p>", subject: "${errorreportDesc}", to: "${emailRecipients}"
    }
