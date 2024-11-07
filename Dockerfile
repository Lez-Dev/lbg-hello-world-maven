# Use an official Maven image to build the project
FROM maven:3.8.1-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml .
COPY src ./src

# Build the Maven project
RUN mvn clean package

# Use an official Java runtime as the base image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/hello-world-maven-1.0-SNAPSHOT.jar .

# Expose the port that the application runs on
EXPOSE 8080

# Define the entrypoint command to run the application
CMD ["java", "-jar", "hello-world-maven-1.0-SNAPSHOT.jar"]
