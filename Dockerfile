FROM maven:3.6.3-jdk-8 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

FROM java:8-jdk-alpine
COPY --from=build /usr/src/app/target/trade_simulator-0.0.1-SNAPSHOT.jar /usr/app/app.jar
WORKDIR /usr/app
EXPOSE 8081
ENTRYPOINT ["java","-jar","app.jar"]