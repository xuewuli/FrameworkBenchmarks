FROM maven:3.6.1-jdk-11-slim as maven
WORKDIR /dropwizard
COPY pom.xml pom.xml
COPY src src
RUN mvn package -q -P mysql

FROM openjdk:11.0.3-jre-slim
WORKDIR /dropwizard
COPY --from=maven /dropwizard/target/hello-world-0.0.1-SNAPSHOT.jar app.jar
COPY hello-world-mysql.yml hello-world-mysql.yml
CMD ["java", "-jar", "app.jar", "server", "hello-world-mysql.yml"]
