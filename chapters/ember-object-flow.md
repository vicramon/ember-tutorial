# Ember Object Flow

(**Again, you don't need to add the following code to your app. You can add it just to play with it, but then delete it.**)

Let's say we have a route called `about`.

```coffee
App.Router.map ->
  @route 'about'
```
```javascript
App.Router.map(function() {
  this.route('about');
})
```

What actually happens when you go to it? It will instantiate a series of objects with the same name as the route... kind of like Rails!

When a route is activated Ember flows downwards from Route, to Controller, to View, to Template. In this case our about route will look for the following in this order: `AboutRoute`, `AboutController`, `AboutView`, and a template named `about.js.emblem` (or `about.hbs` if you're using Handlebars).

When it finds each object it will call specific functions, or hooks on that object. I'm going to cover those hooks later, so for now I'm just going to place a console log in `init` so you can see that these objects are instantiated.

When you go to the about route, which would be `http://localhost:3000/#/about`, all of these console logs will get called, in this order:

```coffee
# app/assets/javascripts/routes/about.js.coffee
App.AboutRoute = Ember.Route.extend
  init: ->
    @_super()
    console.log 'route called'

# app/assets/javascripts/controllers/about.js.coffee
App.AboutController = Ember.Controller.extend
  init: ->
    @_super()
    console.log 'controller called'


# app/assets/javascripts/views/about.js.coffee
App.AboutView = Ember.View.extend
  init: ->
    @_super()
    console.log "view called"

# app/assets/javascripts/templates/about.js.emblem
h1 Template rendered!
```
```javascript
// app/assets/javascripts/routes/about.js
App.AboutRoute = Ember.Route.extend({
  init: function() {
    this._super();
    console.log('route called');
  }
})

// app/assets/javascripts/controllers/about.js
App.AboutController = Ember.Controller.extend({
  init: function() {
    this._super();
    console.log('controller called');
  }
})


// app/assets/javascripts/views/about.js
App.AboutView = Ember.View.extend({
  init: function() {
    this._super();
    console.log('view called');
  }
})

// app/assets/javascripts/templates/about.js.emblem
h1 Template rendered!
```

Ember actually won't complain if it can't find any of these objects. Instead it will just create them for you in memory. So if you don't need to do anything in the `AboutController`, `AboutView`, or `AboutRoute` then just don't create them.

This is what I call the Ember Object Flow. When a route is activated it flows downwards to its associated objects.

Now that you understand the flow of objects in the Ember system I'm going to provide brief overview of each one.
