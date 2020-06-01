
FROM openjdk:9-jdk

MAINTAINER jcustenborder@gmail.com

ARG MAVEN_VERSION='3.6.3'
ARG DOCKER_COMPOSE_VERSION='1.25.5'
ARG USER_HOME_DIR='/home/jenkins'


RUN groupadd -g 994 docker
RUN useradd --uid 1000 -m -G docker jenkins

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install lsb-release git graphviz apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
        | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

RUN curl -L https://github.com/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
##ENV JAVA_HOME=/etc/alternatives/java_sdk_1.8.0
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

USER jenkins
