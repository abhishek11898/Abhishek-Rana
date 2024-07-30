
# Use the official Ruby image from the Docker Hub
FROM ruby:2.6.3
RUN apt-get update && apt-get install -y nodejs
WORKDIR /app
COPY Gemfile* .
RUN gem install bundler:2.4.22
RUN bundle install
RUN bundle exec rails --version
COPY . .
EXPOSE 8081
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8081"]

