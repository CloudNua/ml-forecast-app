#!/bin/sh -e
set -x

# build stage script
if ! docker info &>/dev/null; then
  if [ -z "$DOCKER_HOST" -a "$KUBERNETES_PORT" ]; then
    export DOCKER_HOST='tcp://localhost:2375'
  fi
fi

if [[ -n "$CI_REGISTRY_USER" ]]; then
  echo "Logging to GitLab Container Registry with CI credentials..."
  docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" "$CI_REGISTRY"
fi

docker pull $CONTAINER_TEST_IMAGE
docker tag $CONTAINER_TEST_IMAGE $CONTAINER_RELEASE_IMAGE
docker push $CONTAINER_RELEASE_IMAGE
