FROM tomcat:9.0-alpine
RUN mkdir -p /opt/petclinic
COPY target/*.jar /opt/petclinic/
CMD java - jar /opt/petclinic/*.jar
