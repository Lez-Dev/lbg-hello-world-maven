# Use image to build the project
FROM maven:3.8.1-openjdk-11 AS build

# Set working directory
WORKDIR /app

# Copy the project files to the container
COPY pom.xml .
COPY src ./src

# Build
RUN mvn clean package

# Use Java runtime as the base image
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy the JAR file
COPY --from=build /app/target/hello-world-maven-1.0-SNAPSHOT.jar .

# Expose the port that the application runs on
EXPOSE 8080

# Define the entrypoint command to run the application
CMD ["java", "-jar", "hello-world-maven-1.0-SNAPSHOT.jar"]
