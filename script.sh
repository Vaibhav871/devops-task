#!/bin/bash

set -euo pipefail

# Global variables
DOCKER_USER="vaibhav871"
FRONTEND_REPO="frontend"
BACKEND_REPO="backend"
DOCKER_COMPOSE_FILE="./docker-compose.yml"

# Functions

build_images() {
    local frontend_version backend_version

    printf "Building Docker images...\n"

    # Build frontend
    frontend_version=$(git rev-parse --short HEAD)
    docker build -t "${DOCKER_USER}/${FRONTEND_REPO}:${frontend_version}" ./frontend || return 1

    # Build backend
    backend_version=$(git rev-parse --short HEAD)
    docker build -t "${DOCKER_USER}/${BACKEND_REPO}:${backend_version}" ./backend || return 1

    printf "Frontend version: %s\n" "${frontend_version}"
    printf "Backend version: %s\n" "${backend_version}"

    export FRONTEND_VERSION="${frontend_version}"
    export BACKEND_VERSION="${backend_version}"
}

tag_and_push_images() {
    printf "Tagging and pushing images to Docker Hub...\n"

    docker push "${DOCKER_USER}/${FRONTEND_REPO}:${FRONTEND_VERSION}" || return 1
    docker push "${DOCKER_USER}/${BACKEND_REPO}:${BACKEND_VERSION}" || return 1

    printf "Images pushed successfully.\n"
}

update_docker_compose() {
    printf "Updating Docker Compose file with new versions...\n"

    if [[ ! -f ${DOCKER_COMPOSE_FILE} ]]; then
        printf "Docker Compose file %s does not exist.\n" "${DOCKER_COMPOSE_FILE}" >&2
        return 1
    fi

    sed -i.bak -E \
        -e "s|image: ${DOCKER_USER}/${FRONTEND_REPO}:.*|image: ${DOCKER_USER}/${FRONTEND_REPO}:${FRONTEND_VERSION}|" \
        -e "s|image: ${DOCKER_USER}/${BACKEND_REPO}:.*|image: ${DOCKER_USER}/${BACKEND_REPO}:${BACKEND_VERSION}|" \
        "${DOCKER_COMPOSE_FILE}" || return 1

    printf "Docker Compose file updated.\n"
}

run_docker_compose() {
    printf "Starting the application using Docker Compose...\n"

    docker-compose down || return 1
    docker-compose up -d || return 1

    printf "Application started successfully.\n"
}

main() {
    build_images || { printf "Image building failed.\n" >&2; exit 1; }
    
    update_docker_compose || { printf "Docker Compose update failed.\n" >&2; exit 1; }
    run_docker_compose || { printf "Docker Compose run failed.\n" >&2; exit 1; }
    tag_and_push_images || { printf "Image tagging/pushing failed.\n" >&2; exit 1; }
}

# Entry point
main "$@"
