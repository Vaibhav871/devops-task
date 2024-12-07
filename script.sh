#!/bin/bash

# Configuration
FRONTEND_PATH="./frontend" # Path to frontend directory
BACKEND_PATH="./backend"   # Path to backend directory
FRONTEND_IMAGE="vaibhav871/frontend"
BACKEND_IMAGE="vaibhav871/backend"
FRONTEND_VERSION="v1.0.0"
BACKEND_VERSION="v1.0.0"
DOCKER_COMPOSE_FILE="./docker-compose.yml"

# Helper function to check last command status
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error occurred during: $1"
        exit 1
    fi
}

echo "Building Docker images..."

# Build Frontend Image
docker build -t ${FRONTEND_IMAGE}:${FRONTEND_VERSION} ${FRONTEND_PATH}
check_status "Building Frontend Image"

# Build Backend Image
docker build -t ${BACKEND_IMAGE}:${BACKEND_VERSION} ${BACKEND_PATH}
check_status "Building Backend Image"

echo "Tagging and pushing images to Docker Hub..."

# Push Frontend Image
docker push ${FRONTEND_IMAGE}:${FRONTEND_VERSION}
check_status "Pushing Frontend Image"

# Push Backend Image
docker push ${BACKEND_IMAGE}:${BACKEND_VERSION}
check_status "Pushing Backend Image"

echo "Updating Docker Compose file with new image versions..."

# Update docker-compose.yml with new versions
sed -i "s|\(image: ${FRONTEND_IMAGE}\):.*|\1:${FRONTEND_VERSION}|" ${DOCKER_COMPOSE_FILE}
check_status "Updating Frontend Version in Docker Compose"

sed -i "s|\(image: ${BACKEND_IMAGE}\):.*|\1:${BACKEND_VERSION}|" ${DOCKER_COMPOSE_FILE}
check_status "Updating Backend Version in Docker Compose"

echo "Restarting application with Docker Compose..."

# Stop any running containers
docker-compose down

# Start the application
docker-compose up -d --build
check_status "Starting Application"

echo "Deployment successful!"
