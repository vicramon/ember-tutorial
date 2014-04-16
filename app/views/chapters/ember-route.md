# Ember Route

The first object we'll be covering is the Ember Route object. This is different from the Router. The **Router** creates url routes that map to a flow of objects. A **Route** object is a specific type of Ember object that helps you setup and manage what happens when you visit that url route.

Let's say we want to show a list of users. First we would make the following route:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.map ->
  @resource 'users'
```

Now when you visit `/users`, Ember will look for a `UsersRoute` object. Here's how that could look:

```coffee
# app/assets/javascripts/routes/users.js.coffee
App.UsersRoute = Ember.Route.extend

  model: -> @store.findAll 'user'
```

`model` is a function hook that's called upon entering a route. The result of the model function is then accessible by other objects.

## Route Hooks

Route objects are really all about using these hooks to prepare data and perform any setup actions required for the controller.

`model` is just one of a series of hooks that are called when you enter a route. Here are a few more that you'll get to know, listed in order of when they are called. (`Em.K` is simply a placeholder that returns `this`.) 

```coffee
# app/assets/javascripts/routes/users.js.coffee
App.UsersRoute = Ember.Route.extend

  activate: -> Em.K

  beforeModel: (transition) -> Em.K

  model: (params, transition) -> Em.K

  afterModel: (transition, model) -> Em.K

  setupController: (controller, model) ->
    controller.set 'model', model

  deactivate: -> Em.K
```

`activate` is a hook that's called as soon as your route is hit.

`beforeModel` is called immediately before `model` is called.

`model` we already went over.

`afterModel` is called after the model is resolved.

`setupController` is where you would do any additional controller setup.

`deactivate` is called when you exit the route. Note that it will not get called if you just change the model but stay on the same route. For example `deactivate` would not get called if you changed from `/users/1` to `/users/2`
