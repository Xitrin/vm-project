node('node1') {
    checkout scm
    stage('Script') {
        echo "Build number is ${currentBuild.number}"
        sh 'sudo ./vm.sh golden ntest-${currentBuild.number}'
	cleanWs()
    }
}
