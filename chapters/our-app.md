# Our App

We are going to build a relatively simple CRM. This is a good project for Ember because we'll be searching, listing, showing, and editing records. If you can build this app and understand how it works then you will be well on your way to developing your own complex front-end apps.

You can look at [a completed version](http://embercrm.herokuapp.com) of the app to see what you'll be building.

The main object in this system is the **lead**. If you don't know the term, a lead is the same thing as a potential sales prospect.

## Preparing The App

You can use the Hello World app we built earlier as the base for this app. I'm going to provide you with markup and styles so that you can just focus on the Ember stuff.

[Download this stylesheet](/tutorial/application.css) and save it to `app/assets/stylesheets/application.css`.

## Preparing Routes

Let's use the AutoLocation API to get rid of hashes in our urls. We also need to set the rootURL to `'/'` so Ember knows where to start parsing the url from.

Open your router and add the following to the top:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.reopen
  location: 'auto'
  rootURL: '/'
```

We also need to create a catch-all Rails route to handle whatever arbitrary routes we create in Ember, otherwise we'll get a 404 when we try to reload the page on an Ember subroute:

```ruby
# config/routes.rb

# add this to the bottom of your Rails routes
get '*path', to: 'home#index'
```
