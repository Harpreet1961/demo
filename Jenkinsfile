def emailRecipients = "aparupmandal@gmail.com"
def fromAddress = "aparupmandal@gmail.com"
def inforeportDesc = "Info Notification Queue"
def errorreportDesc = "Error Notification Queue"

pipeline {    
   agent {
      label 'Secondary'
  }
 
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

        stage('Gather Data') {
            steps {
            echo "Collecting the sqs queue size"
            result = sh "${env.WORKSPACE}/demo/tree/sqs/get_sqs_queue.sh", returnStdout: true
		}
                        if (result==0)
                        {
                                echo "Send Info Email"
                                sendEmail(inforeportDesc,emailRecipients)
                        }
                        else
                        {
                                echo "Send Error Email"
                                sendEmail(errorreportDesc,emailRecipients)
                        }
                }
        }
	}

      //  void sendEmail(reportDesc,emailRecipients) {
      //  emailext body: "<p>Hi,<br /><br />There is queue in SQS topic.<br /><br />Thanks<br />Team</p>", subject: "${reportDesc}", to: "${emailRecipients}"
      //  }

