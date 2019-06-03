FROM ruby:2.6-alpine3.8

RUN apk add --update build-base nodejs nodejs-npm postgresql-dev postgresql-client file yarn git less gcc g++ musl-dev make
RUN mkdir /workdir
WORKDIR /workdir
COPY . /workdir

RUN gem install bundler:2.0.1
RUN bundle install

WORKDIR /workdir/lib
EXPOSE 4000
