# Deploying to Heroku

<!-- issue: gitkeep in components? -->

The world should see our masterpiece. If you use Git and Heroku then you can deploy your app very quickly.

First add the `rails_12factor` gem that Heroku likes you to have. Bundle and commit. Then run these commands:

```shell
heroku create <whatever-name-you-want>
git push heroku master
heroku run rake db:migrate db:populate
heroku open
```

And that's it!
