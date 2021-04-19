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

docker build \
  --build-arg BUILDPACK_URL="$BUILDPACK_URL" \
  --build-arg HTTP_PROXY="$HTTP_PROXY" \
  --build-arg http_proxy="$http_proxy" \
  --build-arg HTTPS_PROXY="$HTTPS_PROXY" \
  --build-arg https_proxy="$https_proxy" \
  --build-arg FTP_PROXY="$FTP_PROXY" \
  --build-arg ftp_proxy="$ftp_proxy" \
  --build-arg NO_PROXY="$NO_PROXY" \
  --build-arg no_proxy="$no_proxy" \
  $AUTO_DEVOPS_BUILD_IMAGE_EXTRA_ARGS \
  --tag $TAG_NAME .

docker push $TAG_NAME
