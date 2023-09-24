#!/bin/bash
#
# Runs specific command for Jekyll.

if [ "$1" == "new" ]; then
  bundle exec \
    jekyll new \
      --skip-bundle \
      "${JEKYLL_SITE_NAME}"
elif [ "$1" == "serve" ]; then
  cd "${JEKYLL_SITE_NAME}" || exit 2

  bundle install
  bundle add webrick -v "1.8.1"

  echo
  echo "About to run Jekyll on host URLs:"
  echo "  Regular:     http://localhost:${JEKYLL_PORT}"
  echo "  LiveReload:  http://localhost:${JEKYLL_PORT_LIVERELOAD}"
  echo

  bundle exec \
    jekyll serve \
      --host "0.0.0.0" \
      --port "${JEKYLL_PORT}" \
      --livereload \
      --livereload-port "${JEKYLL_PORT_LIVERELOAD}"
else
  echo "error: Command was not resolved by entrypoint script: $1" 1>&2
fi
