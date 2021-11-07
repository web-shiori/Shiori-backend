HEROKU_API_KEY=$HEROKU_API_KEY heroku config:add RAILS_ENV=production -a web-shiori
HEROKU_API_KEY=$HEROKU_API_KEY heroku container:push web -a web-shiori
HEROKU_API_KEY=$HEROKU_API_KEY heroku container:release web -a web-shiori
HEROKU_API_KEY=$HEROKU_API_KEY heroku run rails db:migrate -a web-shiori
HEROKU_API_KEY=$HEROKU_API_KEY heroku run rails assets:precompile -a web-shiori
