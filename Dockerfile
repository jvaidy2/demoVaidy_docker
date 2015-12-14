#This is our first custom dockerfile
FROM ubuntu:latest
MAINTAINER jvaidyaa "jvaidy@yahoo.com"

EXPOSE 8080

RUN echo “ Installing java8”
RUN apt-get purge openjdk* -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update -y
RUN curl -s -k -L -C - -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u25-b17/server-jre-8u25-linux-x64.tar.gz | tar xz \
 && ln -s /jdk1.8.0_25/bin/* /usr/bin/

COPY docker.init/ /docker.init
RUN find /docker.init -type f -name '*.sh' -exec chmod o+x {} \; \
    && mkdir -p /data/logs

COPY  target/demo.war /data/demo.war

CMD ["/docker.init/start.sh"]
