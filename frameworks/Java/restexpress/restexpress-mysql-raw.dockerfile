FROM maven:3.6.1-jdk-11-slim as maven
WORKDIR /restexpress
COPY src src
COPY src/main/resources/config/dev/mysql-environment.properties src/main/resources/config/dev/environment.properties
COPY pom.xml pom.xml
RUN mvn package -q

FROM openjdk:11.0.3-jre-slim
WORKDIR /restexpress
COPY --from=maven /restexpress/target/world-1.0-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]
