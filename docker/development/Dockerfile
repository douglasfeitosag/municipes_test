FROM ruby:3.3.0

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs npm


COPY Gemfile Gemfile.lock ./

RUN bundle install

RUN npm install flowbite

COPY . .

ENTRYPOINT ["/app/bin/docker-entrypoint"]

EXPOSE 3000

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]