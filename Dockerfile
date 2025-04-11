FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  libvips \
  nodejs \
  yarn

WORKDIR /app

RUN gem install bundler

COPY ./zendeet/Gemfile ./

RUN bundle install

COPY ./zendeet .

EXPOSE ${PORT:-3000}