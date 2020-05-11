FROM ruby:2.7.0
LABEL author:Rafael Domingues Teixeira <rafael991_@hotmail.com>

ENV NODE_VERSION 12

# SETUP ENVIRONMENT FOR YARN
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee \
  /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq

RUN apt-get install -y build-essential nodejs

# CREATE AND SET DEFATUL WORK DIRECTORY
RUN mkdir -p /account_movement_challenge
WORKDIR /account_movement_challenge

# COPIED GEMFILE TO WORK DIRECTORY
COPY Gemfile /account_movement_challenge/Gemfile
COPY Gemfile.lock /account_movement_challenge/Gemfile.lock

RUN bundle install
COPY . /account_movement_challenge

EXPOSE 3000

# Start the main process.
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]
