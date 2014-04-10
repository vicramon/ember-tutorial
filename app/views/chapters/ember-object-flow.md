# Ember Object Flow

Let's say we have a route called `about`.

```coffee
App.Router.map ->
  @route 'about'
```

What actually happens when you go to it? It will instantiate a series of objects with the same name as the route. Hey, that's kind of like Rails!

When a route is activated, Ember flows downwards from Route, to Controller, to View, to Template. In this case our about route will look for the following in this order: `AboutRoute`, `AboutController`, `AboutView`, and a template named `about.js.emblem` (or `about.html.hbs` if you're not using Emblem).

When it finds each object it will call specific functions, or hooks on that object. I'm going to cover what those hooks are for each object later, so for now I'm just going to place a console log in `init` so you can see that these objects are instantiated.

When you go to the about route (try: `http://localhost:3000/#/about`) all of these console logs will get called, in this order:

```coffee
# app/assets/javascripts/routes/about.js.coffee
AboutRoute = Ember.Route.extend
  init: ->
    @_super()
    console.log 'route called'

# app/assets/javascripts/controllers/about.js.coffee
AboutController = Ember.Controller.extend
  init: ->
    @_super()
    console.log 'controller called'


# app/assets/javascripts/views/about.js.coffee
AboutView = Ember.View.extend
  init: ->
    @_super()
    console.log "view called"

# app/assets/javascripts/templates/about.js.emblem
h1 All about me
```

Note that if you visit the about route again only the view will be re-initialized. This is because the controller and route will stay in memory even if you change routes.

Ember actually won't complain if it can't find any of these objects. Instead it will just create them for you in memory. So if you don't need to do anything in the `AboutController`, `AboutView`, or `AboutRoute` then just don't create them.

This is what I call the Ember Object Flow. When a route is activated it flows downwards to its associated objects.

Now that you undestand the flow of objects in the Ember system, I'm going to give you a brief overview of each one.
