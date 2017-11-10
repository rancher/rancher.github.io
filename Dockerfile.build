FROM jekyll/jekyll:3.6 AS builder
WORKDIR /build
COPY Gemfile /build
COPY Gemfile.lock /build
COPY _config.yml /build
RUN chown -R jekyll:jekyll /build && jekyll build
COPY . /build

# Set up the latest pages that get converted into redirects
ENV OS_DOCS_LATEST v1.0
RUN mkdir -p os/latest/en \
    && cp -r os/v1.0/en/* os/latest/en/ \
    && cp -r os/v1.0/en/* os/latest/ \
    && cp -r os/v1.0/en/* os/

RUN jekyll build
