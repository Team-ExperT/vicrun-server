FROM ruby:2.2.0

MAINTAINER spondbob spondbob@eamca.com

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /tmp
ADD ./Gemfile /tmp/
ADD ./Gemfile.lock /tmp/
RUN bundle install

RUN mkdir /myapp
ADD . /myapp
WORKDIR /myapp