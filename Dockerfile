FROM ubuntu

#adds the add-apt-repo tool
RUN apt-get install -y software-properties-common

#install oracle java
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer
RUN update-java-alternatives -s java-7-oracle
RUN apt-get install -y oracle-java7-set-default
RUN ln -s /usr/lib/jvm/java-7-oracle/ /usr/lib/jvm/default-java

#RUN wget http://source.sakaiproject.org/release/10.4/artifacts/sakai-demo-10.4.tar.gz
ADD ./sakai-demo-10.4 /sakai-demo
#RUN tar -xzvf /sakai-demo-10.4.tar.gz
#for some reason it's already unpacked??
WORKDIR /sakai-demo

EXPOSE 8080

CMD ["/bin/bash", "./start-sakai.sh"]
