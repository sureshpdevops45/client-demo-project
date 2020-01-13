FROM centos
MAINTAINER hcladmin@hcl.com
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
RUN curl -O https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-9.0.30/* /opt/tomcat/.
RUN yum -y install java
RUN java -version
RUN value=`cat conf/server.xml` && echo "${value//8080/8090}" >| conf/server.xml
COPY tomcat-users.xml conf/tomcat-users.xml
COPY context.xml webapps/manager/META-INF/context.xml
COPY context-host.xml webapps/host-manager/META-INF/context.xml
COPY var/jenkins_home/workspace/dockerpipeline/target/*.war webapps/myweb.war
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
