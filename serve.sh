#!/bin/bash
#
# Serves Jekyll site in Docker.

set -e

source ./.env

image_name="jekyll-github-pages"

docker build -t "${image_name}" .

docker stop "${image_name}" 2>/dev/null || true

docker run \
  -it \
  --rm \
  --name "${image_name}" \
  -v "$(pwd)/${JEKYLL_SITE_NAME}:/jekyll/${JEKYLL_SITE_NAME}" \
  -p "${JEKYLL_PORT}:${JEKYLL_PORT}" \
  -p "${JEKYLL_PORT_LIVERELOAD}:${JEKYLL_PORT_LIVERELOAD}" \
  "${image_name}" \
  serve
