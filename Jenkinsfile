pipeline {   
   agent {
     kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata:
          name: mypod
          namespace: default
        spec:
          serviceAccount: kube-admin
          containers:
          - name: build-agent
            image: careem785/vlx-cd:latest
            command: 
             - cat
            tty: true
      '''
        }
    }

 stages {     
      stage('Helm Chart'){
        steps{
          container('build-agent'){
              dir('Helm/ttrend-cd') {
                withCredentials([usernamePassword(credentialsId: 'jfrog-cred', usernameVariable: 'username', passwordVariable: 'password')]){
                      sh 'helm repo add ttrend-local  https://vlx.jfrog.io/artifactory/vlx2-helm-local --username $username --password $password'
                      sh "helm repo update"
                      sh "helm install tweet-trend ttrend-local/tweet-cd  -f values.yaml"
                      sh "helm list -a "
                  }
                }
             }
          }
      }

    // stage('Deploy Ingress'){
    //     steps {
    //       container('build-agent'){
    //         dir('ingress') {
    //       echo "-------------------------------Ingress Deployment started---------------------------"
    //       sh './ingress.sh'
    //       echo "-------------------------------Ingress Deployment completed---------------------------"
    //         }
    //       }
    //     }
    //   }
   }
}
