node('node1') {
    checkout scm
    stage('Provision') {
        sh "sudo ./provision.sh golden ntest-${currentBuild.number}"
    }
    stage('Deploy') {
        sh "sudo ./deploy.sh ntest-${currentBuild.number}"
    }
    stage('Test') {
        sh "sudo ./test.sh ntest-${currentBuild.number}"
    }
    stage('Clean') {
        sh "sudo ./clean.sh ntest-${currentBuild.number}"
        cleanWs()
    }
}