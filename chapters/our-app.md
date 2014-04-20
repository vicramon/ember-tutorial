# Our App

We are going to build a relatively simple CRM. This is a good project for Ember because we'll be listing data, showing records, editing records, and doing other useful things like searching. If you can build this app and understand how it works then you will be well on your way to developing your own complex front-end apps.

You can see [the completed version](http://embercrm.herokuapp.com) of the app to get an idea of what we'll be doing.

The main object in this system is the **lead**. If you don't know the term, a lead is the same thing as a potential sales prospect . This is what we will be focused on manipulating.

## Preparing The App

You can use the Hello World app we built earlier as the base for this app. I'm going to provide you with markup and styles so that you can just focus on the Ember stuff.

## Preparing Routes

Let's use the AutoLocation API to get rid of those ugly hashes in our urls. We also need to set the rootURL to `'/'` so Ember knows where to start parsing the url from.

Open your router and add the following to the top:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.reopen
  rootURL: '/'
  location: 'auto'
```

We also need to create a catch-all Rails route to handle whatever arbitrary routes we create in Ember, otherwise we'll get a 404 when we reload the page on a subroute:

```ruby
# config/routes.rb

# add this to the bottom of your Rails routes
get '*path', to: 'home#index'
```
