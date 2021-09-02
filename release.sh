heroku container:login
heroku container:push web
heroku container:release web
heroku run rails db:migrate
heroku run rails assets:precompile
