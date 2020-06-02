#!/bin/sh

# Stop script from running if there are any errors
set -e

# Docker image
IMAGE="iamkhan21/nestjs-server"

# Git version with git hash and tags (if they exist) to be used as Docker tag
GIT_VERSION=$(git describe --always --abbrev --tags --long)

# Build and tag new Docker image and push up to Docker Hub
echo "Building and tagging new Docker image: ${IMAGE}:${GIT_VERSION}"
docker build -t ${IMAGE}:${GIT_VERSION} -f Dockerfile.prod .
docker tag ${IMAGE}:${GIT_VERSION} ${IMAGE}:latest

# Login to Docker Hub and push newest build
echo "Logging into Docker and pushing ${IMAGE}:${GIT_VERSION}"
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
docker push ${IMAGE}:${GIT_VERSION}

# Login to SCW server
echo "Connecting SCW"

# Decode SSH key
sudo echo "${DO_SSH_KEY}" | base64 -d > deploy_key

# Log into Droplet, stop the currently running container and start the new one
echo "Stopping container name current and starting ${IMAGE}:${GIT_VERSION}"

#ssh -i ~/deploy_key -t ${INSTANCE} "docker pull ${IMAGE}:${GIT_VERSION} &&
#docker stop current &&
#docker rm current &&
#docker run --name=current --restart unless-stopped -e CLIENT_ID=${CLIENT_ID} -e CLIENT_SECRET=${CLIENT_SECRET} -d -p 80:5000 ${IMAGE}:${GIT_VERSION} &&
#docker system prune -a -f &&
#docker image prune -a -f"

sudo ssh -i deploy_key -t ${INSTANCE} 'echo "append this text" >> check_$(date +%F_%T).txt'
