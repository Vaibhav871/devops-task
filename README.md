
# DevOps Project

## Overview

This document explains the steps for containerizing a full-stack application using Docker, Docker Compose, and Shell scripting. The application comprises a React frontend, an Express backend, and a MongoDB database.

---

## Project Structure

```
project/
├── frontend/                        # React Frontend
│   ├── Dockerfile                   # Frontend container configuration
│   └── (Other frontend files)
├── backend/                         # Express Backend
│   ├── Dockerfile                   # Backend container configuration
│   └── (Other backend files)
├── docker-compose.yml               # Orchestration of services
├── script.sh                    # Automation script
├── README.md                        # Project documentation
└── Demonstration Video              # Screen recording of the working project
```

---

## Prerequisites

1. **Install Docker**: [Download Docker](https://www.docker.com/products/docker-desktop/)
2. **Install Docker Compose**: 
3. **Docker Hub Account**: Create one at [Docker Hub](https://hub.docker.com/).

---

## How to Run

### 1. Clone the Repository
```bash
git clone https://github.com/Vaibhav871/devops-task.git
cd project
```

### 2. Build and Deploy
Run the shell script to automate the build and deployment process:
```./script.sh ```

### 3. Access the Application
- **Frontend**: [http://localhost](http://localhost)
- **Backend**: [http://localhost:5000/api/users](http://localhost:5000/api/users)

---

## Files and Configuration

### Docker Compose File
The `docker-compose.yml` defines services for the frontend, backend, and MongoDB database. Example:

- **Service Definition**:  
  `docker-compose.yml` defines frontend, backend, and MongoDB services with details like images, build contexts, ports, and environment variables.

- **Networking**:  
  Services communicate seamlessly via a dedicated network using service names (e.g., `mongo_db`).

- **Volume Management**:  
  Persistent volumes ensure data retention across container restarts.

- **Orchestration**:  
  Dependencies are managed with `depends_on` for correct service startup order.

- **Single Command Execution**:  
  `docker-compose up` builds, creates, and starts all services.

- **Local Development**:  
  Simplifies running and testing containerized apps in a production-like environment locally.

### Automation Script
The `deploy.sh` script automates building, tagging, and pushing Docker images to Docker Hub, updating the Compose file, and starting services.

---

## Demonstration Video
[https://drive.google.com/file/d/1YESdkBZVBTFpmi0wqelZjNGqjFYiNi44/view?usp=drive_link]



