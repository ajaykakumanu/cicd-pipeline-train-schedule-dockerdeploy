pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
				sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip' 				
            }
        }
         stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
			      echo 'Image starts'
                script {
                    app = docker.build("vakaws/train-schedule")
                     sh 'docker run -p 8082:8080 -d vakaws/train-schedule'
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }
}
