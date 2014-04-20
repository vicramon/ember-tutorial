# Deploying to Heroku

The world should see our masterpiece. We can deploy our app to Heroku with very little hassle.

First add the `rails_12factor` gem that Heroku likes you to have. Bundle and commit then:

```shell
heroku create <whatever-name-you-want>

git push heroku master

heroku run rake db:migrate db:populate

heroku open
```

And that's it!
