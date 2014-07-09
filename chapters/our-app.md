# Our App

**Now we're actually going to code**.

We are going to build a CRM. This is a good project for Ember because we'll be searching, listing, showing, creating, and editing records. If you can build this app and understand how it works then you will be well on your way to developing your own complex front-end apps.

You can look at [a completed version](http://embercrm.herokuapp.com) of the app to see what you'll be building. The code is also on GitHub in case you need a reference: [CoffeeScript Code](https://github.com/vicramon/ember-crm), [Javascript Code](https://github.com/vicramon/ember-crm-js).

The main object in this system is the **lead**. If you don't know the term, a lead is the same thing as a potential customer.

## Preparing The App

You can use the Hello World app we built earlier as the base for this app. I'm going to provide you with styles so that you can just focus on the Ember stuff:

[Download this stylesheet](https://gist.githubusercontent.com/vicramon/a6cc84a06cf92f4aa191/raw/be5d148eaaf1b28d56d6e57e1653ff3f43158192/application.css) and save it to `app/assets/stylesheets/application.css`, replacing your existing `application.css`.

## Vim Projections

If you use Vim, there's a very useful plugin called [vim-projectionist](https://github.com/tpope/vim-projectionist) that provides some help in navigating files. Vim projections are great for quickly opening and creating Ember files.

Here's are Gists with the projections that I use: [Coffeescript Projections](https://gist.github.com/vicramon/6488603) or [Javascript Projections](https://gist.github.com/vicramon/b626f24df31a1f64780b). Once you've got vim-projectionist installed, just copy that file into `config/projections.json` and restart Vim.

These projections use `Ej` as a prefix for all things Ember, so you have `Ejmodel`, `Ejcontroller`, `Ejview`, etc. `Ejini` will open your Ember router, which is consistent with `Eini` opening your Rails router.

If you don't use Vim, consider learning it. It will probably improve your programming experience. You can open a terminal and type `vimtutor` to get an instant tutorial. You might also check out [VimGenius](http://vimgenius.com), a little app I built to help you remember commands. Lastly, I wrote a [Vim Tutorial](https://vim.vicramon.com) that will help you get to an intermediate level.

## Preparing Routes

Let's use the AutoLocation API to get rid of hashes in our urls. We also need to set the rootURL to `'/'` so Ember knows where to start parsing the url from.

Open your router and add the following to the top:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.reopen
  location: 'auto'
  rootURL: '/'
```
```javascript
// app/assets/javascripts/router.js
App.Router.reopen({
  location: 'auto',
  rootURL: '/'
})
```

We also need to create a catch-all Rails route to handle whatever arbitrary routes we create in Ember, otherwise we'll get a 404 when we try to reload the page on an Ember subroute:

```ruby
# config/routes.rb

# add this to the bottom of your Rails routes
get '*path', to: 'home#index'
```
