node('node1') {
    checkout scm
    try {
        stage('Create NGINX container') {
            sh "docker-compose -f /home/jenkins/vm-project/nginx-container up -d"
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
        sh 'docker-compose -f /home/jenkins/vm-project/nginx-container down'
        sh 'docker ps'
        cleanWs()
    }
}
