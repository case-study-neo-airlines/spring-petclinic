FROM tomcat:9.0-alpine
RUN mkdir -p /opt/petclinic
COPY petclinic.jar /opt/petclinic/petclinic.jar
CMD java - jar /opt/petclinic/petclinic.jar
