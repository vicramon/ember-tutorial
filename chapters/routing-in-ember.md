# Routing in Ember

Everything in Ember starts with routes. If you're familiar with routing systems in other frameworks then I don't think Ember's will cause you much trouble.

## Location APIs

First, let's cover the mechanics of routing in Ember. By default Ember uses the `hashchange` event in the browser to know when you've changed routes. It implements its own [HashLocation](http://emberjs.com/api/classes/Ember.HashLocation.html) object to handle this.

With HashLocation, an Ember route will be visible after the `#` in your url. For example, your routes might look like:

`http://myemberapp.com/#/`

`http://myemberapp.com/#/about`

`http://myemberapp.com/#/users/1`

`http://myemberapp.com/#/users/1/edit`

You may not want to serve your Ember app directly from your root url. In this case, just tell Ember what the root url should be:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.reopen
  rootURL: '/some/path/'
```

Now your users index route would look like this:

`http://myemberapp.com/some/path/#/users`

Some of you may think that hashes look ugly. There's a solution to that! Ember also implements a [HistoryLocation](http://emberjs.com/api/classes/Ember.HistoryLocation.html) class which will handle routes by using your browser's history API.

Here's how to use HistoryLocation instead of HashLocation:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.reopen
  location: 'history'
```

Boom, it's that simple.

Not all browsers implement the history API. Luckily Ember comes to the rescue again with AutoLocation, which  will use HistoryLocation if the user's browser supports it, otherwise it will use HashLocation.

```coffee
App.Router.reopen
  location: 'auto'
```

Both HashLocation and HistoryLocation implement Ember's [Location API](http://emberjs.com/api/classes/Ember.Location.html#toc_location-api). You could write your own Location class if you wanted to use something other than hashes or history, it would just need to respond properly to the API.

## Writing Routes

A set of CRUD routes might look like this:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.map ->
  @resource 'users'
  @route 'user.new', path: '/users/new'
  @resource 'user', path: '/users/:id'
    @route 'edit'
```

This would generate the following routes:

`/users` (index)

`/users/new` (new)

`/users/:id` (show)

`/users/:id/edit` (edit)

Delete and create would be handled by custom actions so they don't need to be routes.

There are two functions in use here: `resource` and `route`. The difference between them is important.

You can use `resource` to take in a param in order to get a specific record. You can nest things under `resource`.

You use `route` to specify some new UI that doesn't need a specific record. `route` is a dead end -- you cannot nest things under it. It can not take in params.

The `.` that you see is simply an alternative to using camel case. `user.new` could just as well be `userNew`. Both of these will look for a series of objects who's names start with UserNew.

## Nested Routes Means Nested UI

In Ember, the UI for any active route will be visible by default. Take for example the following routes:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.map ->
  @resource 'posts', path: '/posts'
    @route 'new', path: '/new'
```

When you visit `http://localhost:3000/posts/new`, you will see both `posts` template and the `posts/new` template. The `posts` template will need an `outlet` tag inside itself to specify where `posts/new` will appear.

This is very different from server-side development where every route can have totally different UI. If you see a route in Ember in the url bar, that means that it is active and it's UI should be visible. This is a feature. It allows you to compartmentalize UI that builds on top of other UI, so this pattern makes a lot of sense for the front-end.

## See Your Routes

I recommend playing around with the router in your hello world app. It's located in `app/assets/javascripts/router.js.coffee`. Once you've added routes you can refresh your page and look at the Ember inspector to see what routes Ember has generated. The Ember Inspector will also show you which Route, Controller, View, and Template that route will look for. This is extremely useful for making sure your object names match up.

## Conclusion

If you're interested in learning more about routes I recommend [the Ember docs](http://emberjs.com/guides/routing/) section on routing. There are also two tables in the [Defining your Routes](http://emberjs.com/guides/routing/defining-your-routes/#toc_resources) guide that really illuminate how you can use `route` and `resource` to create you your ideal routes.

In the next chapter we'll go over what the route actually does when you hit it.
