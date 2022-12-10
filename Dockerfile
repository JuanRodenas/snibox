FROM ruby:2.6.8-alpine
LABEL author="juan rodenas"

RUN apk add --no-cache \
    git \
    build-base \
    tzdata \
    nodejs \
    yarn \
    sqlite-dev \
    bash \
    postgresql-dev \
    python2 \
    redis \
    && rm -rf /var/cache/apk/*

WORKDIR /app


ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_ENV production
ENV RACK_ENV production
ENV NODE_ENV production

ENV SECRET_KEY_BASE="08898973823f6f1d121ce30fb8adc1c559dcfc08f358cfc0298e4aad81b8c9d798e8249e3a4b26c04255cf8b2d71eaf8eda865d173ae3fe6fb1a599d1b1fa260"

RUN git clone https://github.com/MohamedElashri/snibox-1 /app && cd /app
COPY . /app

RUN bundle update --bundler

RUN gem install bundler:1.17.2

RUN bundle update rails

RUN echo "gem 'sqlite3', '~> 1.3.6'" >> Gemfile
RUN echo "gem 'redis', '~> 5.0', '>= 5.0.5'" >> Gemfile
RUN gem install bundler && bundle install

VOLUME /app/db/database

RUN yarn install --check-files; bundle exec rake assets:precompile

RUN apk del \
    git \
    python2 \
    build-base \
    && rm -rf /var/cache/apk/*

EXPOSE 3000

CMD if [ -f /app/tmp/pids/server.pid ]; then rm -f /app/tmp/pids/server.pid; fi && cd /app && bundle exec rake 'db:migrate' && bundle exec rails server -b 0.0.0.0