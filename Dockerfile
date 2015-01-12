from dockerfile/ubuntu


#install oracle java
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer
RUN update-java-alternatives -s java-7-oracle
RUN apt-get install -y oracle-java7-set-default
RUN ln -s /usr/lib/jvm/java-7-oracle/ /usr/lib/jvm/default-java

#install tomcat
RUN wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.8/bin/apache-tomcat-7.0.8.tar.gz
RUN tar xfz apache-tomcat-7.0.8.tar.gz
RUN mv apache-tomcat-7.0.8 /tomcat
RUN rm -rf /tomcat/webapps/*

#install git
RUN sudo apt-get install git

#Download Sakai source
RUN git clone https://github.com/sakaiproject/sakai.git

RUN apt-get install -y maven
WORKDIR /root/sakai
RUN mvn clean install sakai:deploy -Dmaven.tomcat.home=/tomcat



