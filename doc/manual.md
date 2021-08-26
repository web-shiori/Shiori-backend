# 開発の手順
- Dockerfileを以下にする(リロードしなくても修正を反映させるため)
```dockerfile
# syntax=docker/dockerfile:1
FROM ruby:2.5.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
```
- 開発する
- Dockerfileを以下にする
```dockerfile
FROM ruby:2.5.5
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
```
- デプロイ

```shell
$ sh release.sh
$ heroku run rails db:migrate
$ heroku run rails assets:precompile
```

# その他
- herokuの環境設定
```shell
heroku config:add RAILS_ENV=production
```

- herokuの環境変数: https://qiita.com/opiyo_taku/items/a753623a4a565424dfec
- herokuのDBにアクセスする
```shell
heroku pg:psql
```
