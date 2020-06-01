#!groovy
@Library('jenkins-pipeline') import com.github.jcustenborder.jenkins.pipeline.DockerPipeline

def pipe = new DockerPipeline()
pipe.imageName = 'jenkins-maven-jdk9'
pipe.majorVersion = 0
pipe.minorVersion = 0
pipe.repositories = [
        ['credential': 'custenborder_docker', 'registry': 'https://docker.custenborder.com', 'repository': 'jcustenborder']
]
pipe.execute()
