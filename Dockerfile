FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /the-globe-church
WORKDIR /the-globe-church
COPY Gemfile /the-globe-church/Gemfile
COPY Gemfile.lock /the-globe-church/Gemfile.lock
RUN bundle install
COPY . /the-globe-church
