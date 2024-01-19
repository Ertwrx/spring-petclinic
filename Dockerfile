# Stage 1: Build stage
FROM schoolofdevops/maven:spring AS build

WORKDIR /app

COPY . .

RUN mvn spring-javaformat:apply && \
    mvn package -DskipTests

# Stage 2: Final image
FROM adoptopenjdk:11-jre-hotspot

WORKDIR /app

COPY --from=build /app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /run/petclinic.jar

EXPOSE 8080

CMD ["java", "-jar", "/run/petclinic.jar"]
