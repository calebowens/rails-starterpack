FROM ruby:3.2.2-bookworm

WORKDIR /app

RUN apt update -qq && apt upgrade -yqq && apt install chromium -yqq

EXPOSE 3000
