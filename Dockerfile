# --- STAGE 1: THE BUILDER (The Kitchen) ---

FROM maven:3.9-eclipse-temurin-17-alpine AS build
WORKDIR /app

# Copy the source code
COPY Backend/todo-summary-assistant/pom.xml .
COPY Backend/todo-summary-assistant/src ./src

# Compile the code (creates the .jar file in /app/target)
RUN mvn clean package -DskipTests

# --- STAGE 2: THE RUNTIME (The Dining Table) ---
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Create a secure user (Requirement: Do not run as root)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# It grabs the .jar from Stage 1 ("build") and puts it here
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]