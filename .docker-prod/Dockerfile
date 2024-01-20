FROM ruby:3.3.0-bookworm

COPY . /app

WORKDIR /app

RUN apt update -qq && apt upgrade -yqq

RUN bundle install
RUN rails assets:precompile

EXPOSE 3000
