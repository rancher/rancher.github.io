FROM jekyll/jekyll:3.4 AS builder
WORKDIR /build
COPY . /build
RUN echo 'URL: "http://rancher.com"' >> _config.yml && echo 'baseurl: "/docs"' >> _config.yml
RUN jekyll build

FROM nginx
COPY --from=builder /build/_site /usr/share/nginx/html/docs
COPY --from=builder /build/favicon.png /usr/share/nginx/html/favicon.png
