FROM ruby:2.2 AS builder
ADD . /site
RUN cd /site && \
    sed -i 's/rancher\.github\.io/rancher\.com/' ./_config.yml && \
    sed -i 's/^\(baseurl:\)\(.*$\)/\1 "\/docs"/' ./_config.yml && \
    bundle install && \
    bundle exec jekyll build

FROM nginx
COPY --from=builder /site/_site /usr/share/nginx/html/docs
RUN rm /usr/share/nginx/html/docs/Gemfile /usr/share/nginx/html/docs/Gemfile.lock
