pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
		echo "Service_PORT=${Service_PORT}"
		echo "Docker_PORT=${Docker_PORT}" 
	        echo 'Running build automation'
				sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip' 				
            }
        }
         stage('Build Docker Image') {
           
            steps {
			      echo 'Image starts'
                script {
                    app = docker.build("vakaws/train-schedule")
                     sh 'docker run -p ${Service_PORT}:${Docker_PORT} -d vakaws/train-schedule'
                }
            }
        }
        stage('Push Docker Image') {
           
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
