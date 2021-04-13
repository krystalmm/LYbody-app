FROM ruby:2.6.3
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs libpq-dev vim
ENV TZ Asia/Tokyo
RUN mkdir /LYbody
WORKDIR /LYbody
COPY Gemfile /LYbody/Gemfile
COPY Gemfile.lock /LYbody/Gemfile.lock
RUN bundle install
COPY . /LYbody
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids