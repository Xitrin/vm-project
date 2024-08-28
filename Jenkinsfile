node('node1') {
    checkout scm
    stage('Script') {
        sh "sudo ./vm.sh golden ntest-${currentBuild.number}"
	cleanWs()
    }
}
