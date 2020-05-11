FROM ruby:2.7.0
LABEL author:Rafael Domingues Teixeira <rafael991_@hotmail.com>

ENV NODE_VERSION 12

# INSTALL DEPENDENCIES
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
