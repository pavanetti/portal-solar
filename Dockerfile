FROM ruby:2.6.3-buster AS build-env

ENV RAILS_ENV production

WORKDIR /application
COPY Gemfile* package.json ./

RUN apt-get update \
  && bundle install --deployment --without development test -j4 --retry 3 \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt install -y nodejs \
  && npm install -g yarn \
  && yarn install

COPY . .
RUN bundle exec rake assets:precompile
RUN rm -rf node_modules tmp/cache app/assets vendor/assets spec
########################################################################
FROM ruby:2.6.3-buster

ENV RAILS_ENV production
ENV EXECJS_RUNTIME Disabled

COPY --from=build-env /usr/local/bundle/ /usr/local/bundle/
COPY --from=build-env /application /application

WORKDIR /application

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]