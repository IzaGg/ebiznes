#base image
FROM ubuntu:18.04

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#java 8
RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y  software-properties-common &&\
    add-apt-repository ppa:openjdk-r/ppa &&\
    apt-get update &&\
    apt-get -y install openjdk-8-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

RUN apt update && apt install -y \
    unzip \
    vim \
    git \
    wget \
    curl


#scala
RUN wget https://scala-lang.org/files/archive/scala-2.12.8.deb &&\
    dpkg -i scala-2.12.8.deb &&\
    apt-get update &&\
    apt-get install scala

#sbt
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list &&\
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add &&\
    apt-get update &&\
    apt-get install sbt

#npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm@latest

EXPOSE 8888
EXPOSE 9000
EXPOSE 8000
EXPOSE 5000

#user
RUN useradd -ms /bin/bash uzytk1
RUN adduser uzytk1 sudo
USER uzytk1
WORKDIR /home/uzytk1/
RUN mkdir /home/uzytk1/work

VOLUME ["home/exchange/"]


