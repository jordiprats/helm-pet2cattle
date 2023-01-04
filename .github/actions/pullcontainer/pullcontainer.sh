#!/bin/bash

LOCALBIN="$HOME/.local/bin"

YQ_VERSION=v4.27.5

OS=$(uname -s | tr [A-Z] [a-z])

case "${OS}" in
    linux*)     ARCH=$(dpkg --print-architecture);;
    darwin*)    ARCH=$(uname -m);;
    *)          echo "error retrieving arch"; exit 1;;
esac

mkdir -p ${LOCALBIN}

YQBIN=$(which yq)
if [ -z "$YQBIN" ];
then
  YQBIN="${LOCALBIN}/yq"
  curl -sSLo "$YQBIN" "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_${OS}_${ARCH}"
  chmod +x "$YQBIN"
fi

CONTAINER_IMAGE=$(cat values.yaml | $YQBIN .image.repository)
CONTAINER_TAG=$(cat Chart.yaml | $YQBIN .appVersion)

docker pull "${CONTAINER_IMAGE}:${CONTAINER_TAG}"
