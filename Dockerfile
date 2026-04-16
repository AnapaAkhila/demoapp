FROM tomcat:9
COPY target/demoapp.war /usr/local/tomcat/webapps/
