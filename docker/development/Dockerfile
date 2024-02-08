FROM ruby:3.3.0

WORKDIR /app

ENV RAILS_ENV="development"

RUN apt-get update -qq && apt-get install -y nodejs npm

RUN gem update --system 3.5.6

COPY Gemfile Gemfile.lock ./

RUN bundle install

RUN npm install flowbite
RUN npm install tailwindcss

COPY . .

EXPOSE 3000
