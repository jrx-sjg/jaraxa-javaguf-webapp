FROM openjdk:8-jdk
ENV PORT 8080
ENV CLASSPATH /opt/lib
EXPOSE 8080 8081

RUN apt-get update; \
    apt-get install ca-certificates-java -y --no-install-recommends;

COPY jce_policy-8.zip /

RUN mkdir -p /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/ && \
    unzip -p /jce_policy-8.zip UnlimitedJCEPolicyJDK8/local_policy.jar > /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/local_policy.jar && \
    unzip -p /jce_policy-8.zip UnlimitedJCEPolicyJDK8/US_export_policy.jar > /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/US_export_policy.jar && \
    rm /jce_policy-8.zip

COPY ldap/certs/absences-management.keystore /opt/cacerts/

# copy pom.xml and wildcards to avoid this command failing if there's no target/lib directory
COPY pom.xml target/lib* /opt/lib/

# NOTE we assume there's only 1 jar in the target dir
# but at least this means we don't have to guess the name
# we could do with a better way to know the name - or to always create an app.jar or something
COPY target/*.jar /opt/app.jar
WORKDIR /opt
COPY entrypoint.sh .

ENTRYPOINT [ "./entrypoint.sh" ]