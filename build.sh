#!/bin/bash

# Use podman to build the container image if it is available

if [ -x podman ]
then
  DOCKER="podman --format docker"
else
  DOCKER=docker
fi

# Set the image name if specified on the command line

IMAGE_NAME="${1:-websvr}"

echo "Building image '${IMAGE_NAME}' with command '${DOCKER}'"

# Build the image

${DOCKER} build -t ${IMAGE_NAME} .
