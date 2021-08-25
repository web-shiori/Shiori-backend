FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client build-essential libpq-dev vim

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN mkdir -p tmp/sockets

# Expose volumes to frontend
VOLUME /app/public
VOLUME /app/tmp

# Start Server
# TODO: environment
CMD bundle exec puma
