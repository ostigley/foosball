FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y mysql-client build-essential libpq-dev apt-transport-https

# Node setup
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs

# Install dependencies in separate stage (better for docker layer cache)
RUN mkdir -p /var/tmp
WORKDIR /var/tmp
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install bundler
RUN NOKOGIRI_USE_SYSTEM_LIBRARIES=1 bundle install

# Copy in rest of the app
RUN mkdir -p /var/archives
WORKDIR /var/archives
COPY . .

# Precompile
RUN NO_DB=nulldb RAILS_ENV=$RAILS_ENV bundle exec rails assets:precompile

EXPOSE 3000

CMD bundle exec puma -C config/puma.rb
