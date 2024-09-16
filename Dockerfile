# syntax=docker/dockerfile:1

# Определение версии Ruby
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim as base

# Установка рабочего каталога для приложения
WORKDIR /app

# Установка переменных окружения для Production
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development test" \
    BUNDLE_GLOBAL_PATH_APPENDS_RUBY_SCOPE=1 \
    SECRET_KEY_BASE_DUMMY=1

# Установка необходимых зависимостей
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
  build-essential \
  libpq-dev \
  curl \
  git \
  libvips \
  nodejs \
  npm \
  postgresql-client \
  && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Установка Yarn вручную, так как установка через `npm` не удалась
ARG YARN_VERSION=1.22.21
RUN npm install -g yarn@$YARN_VERSION

# Копирование Gemfile и установка зависимостей через Bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3 && \
    rm -rf "${BUNDLE_PATH}"/ruby/*/cache

# Копирование файлов проекта
COPY . .

# Предварительная компиляция приложений для ускорения запуска
RUN bundle exec bootsnap precompile app/ lib/

# Установка и сборка зависимостей JavaScript
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile && yarn cache clean

# Компиляция ассетов приложения
RUN SECRET_KEY_BASE=$SECRET_KEY_BASE bundle exec rails assets:precompile

# Установка пользователя rails для безопасности
RUN useradd -m -d /app -s /bin/bash rails && \
    chown -R rails:rails /app /usr/local/bundle

# Переключение на пользователя rails
USER rails

# Определение порта для приложения
EXPOSE 3000

# Стандартная точка входа
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

# Определение команды запуска сервера Rails
ENTRYPOINT ["./bin/rails", "server", "-b", "0.0.0.0"]
