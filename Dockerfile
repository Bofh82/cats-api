#FROM alpine:3.13
#RUN apk add openjdk
FROM openjdk:17

COPY ./target/cats-api-2.7.3.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]