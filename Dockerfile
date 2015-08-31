FROM library/ubuntu:14.04

#adds the add-apt-repo tool
RUN apt-get install -y software-properties-common

#install oracle java 8
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

#install tomcat
WORKDIR /opt
RUN wget http://apache.go-parts.com/tomcat/tomcat-8/v8.0.26/bin/apache-tomcat-8.0.26.tar.gz
RUN tar -zxvf apache-tomcat-8.0.26.tar.gz
RUN mv apache-tomcat-8.0.26 tomcat

# install mysql
#RUN echo "deb http://archiveubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install mysql-server

#install maven & git
RUN apt-get install -y maven
RUN apt-get install -y git

#install sakai
RUN echo 'e'
RUN git clone https://github.com/sakaiproject/sakai.git /sakai
WORKDIR /sakai
RUN mvn dependency:resolve
RUN mvn clean install sakai:deploy -Dmaven.tomcat.home=/tomcat

#configure mysql
ADD ./mysql/my.conf /etc/mysql/my.conf
RUN mysql -uroot "create database sakai default character set utf8;"
RUN mysql -uroot "grant all privileges on sakai.* to 'sakai'@'localhost' identified by 'ironchef';"
RUN mysql -uroot "grant all privileges on sakai.* to 'sakai'@'127.0.0.1' identified by 'ironchef';"

#configure tomcat
ADD ./tomcat/context.xml /tomcat/conf/context.xml
ADD ./tomcat/server.xml /tomcat/conf/server.xml
RUN rm -rf /tomcat/webapps/*
RUN wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz
RUN tar -zxvf mysql-connector-java-5.1.36/mysql-connector-java-5.1.36.tar.gz
RUN mv mysql-connector-java-5.1.36-bin.jar /tomcat/comm

#configure sakai
ADD ./tomcat/sakai.properties /tomcat/sakai/sakai.properties

EXPOSE 8080

CMD ["/bin/bash", "./tomcat/start-sakai.sh"]
