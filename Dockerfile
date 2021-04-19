FROM ruby:2.6.3
RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs libpq-dev vim yarn
RUN apt-get install -y cron
RUN service cron start
ENV TZ Asia/Tokyo
RUN mkdir /LYbody
WORKDIR /LYbody
COPY Gemfile /LYbody/Gemfile
COPY Gemfile.lock /LYbody/Gemfile.lock
RUN bundle install
COPY . /LYbody
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids
RUN touch log/cron.log
RUN bundle exec whenever --update-crontab
CMD ["cron", "-f"]