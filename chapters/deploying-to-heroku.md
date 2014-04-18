# Deploying to Heroku

The world should see our masterpiece. We can deploy our app to Heroku with very little hassle:

```shell
heroku create <whatever-name-you-want>

git push heroku master

heroku run rake db:migrate

heroku run rake db:populate

heroku open
```

And that's it!
