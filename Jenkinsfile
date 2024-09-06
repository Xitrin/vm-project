node('node1') {
    checkout scm
    try {
        stage('Create NGINX container') {
            sh "docker run -it --rm -d -p 8080:80 \
                --name ntest-${currentBuild.number} nginx"
        }
    } catch (Exception e) {
        echo "Create NGINX stage failed"
    }
    try {
        stage('Test') {
            sh 'curl localhost:8080'
        }
    } catch (Exception e) {
        echo "Test stage failed"
    }
    stage('Clean') {
        sh "sudo docker stop ntest-${currentBuild.number}"
        sh 'docker ps'
        cleanWs()
    }
}
