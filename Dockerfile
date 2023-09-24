FROM ruby:3.2.2-alpine3.18

RUN apk add --update \
      bash \
      build-base \
      libxml2-dev \
      libxslt-dev && \
    rm -rf /var/cache/apk/*

WORKDIR /jekyll

COPY Gemfile .

RUN bundle install

COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh

ARG JEKYLL_PORT=80
ENV JEKYLL_PORT=${JEKYLL_PORT}
EXPOSE ${JEKYLL_PORT}

ARG JEKYLL_PORT_LIVERELOAD=35729
ENV JEKYLL_PORT_LIVERELOAD=${JEKYLL_PORT_LIVERELOAD}
EXPOSE ${JEKYLL_PORT_LIVERELOAD}

ARG JEKYLL_SITE_NAME=site
ENV JEKYLL_SITE_NAME=${JEKYLL_SITE_NAME}

ENTRYPOINT [ "./entrypoint.sh" ]
