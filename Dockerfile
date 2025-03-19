FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

WORKDIR /app

RUN gem install bundler -v 2.4.22

COPY Gemfile ./

RUN bundle install

COPY . .

RUN chmod +x ./bin/rails

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]