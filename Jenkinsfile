node('node1') {
    checkout scm
    try {
        stage('Provision') {
            sh "sudo ./provision.sh golden ntest-${currentBuild.number}"
        }
    } catch (Exception e) {
        echo "Provision stage failed"
    }
    try {
        stage('Deploy') {
            sh "sudo ./deploy.sh ntest-${currentBuild.number}"
        }
    } catch (Exception e) {
        echo "Deploy stage failed"
    }
    try {
        stage('Test') {
            sh "sudo ./test.sh ntest-${currentBuild.number}"
        }
    } catch (Exception e) {
        echo "Test stage failed"
    }
    stage('Clean') {
        sh "sudo ./clean.sh ntest-${currentBuild.number}"
        cleanWs()
    }
}
