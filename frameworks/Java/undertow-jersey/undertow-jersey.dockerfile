FROM maven:3.6.1-jdk-11-slim as maven
WORKDIR /undertow-jersey
COPY src src
COPY pom.xml pom.xml
RUN mvn package -q

FROM openjdk:11.0.3-jre-slim
WORKDIR /undertow-jersey
COPY --from=maven /undertow-jersey/target/undertow-jersey.jar app.jar
CMD ["java", "-jar", "app.jar"]
