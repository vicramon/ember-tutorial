# Ember Route

The first object we'll be covering is the Ember Route object. This is different from the Router. The **Router** creates url routes that map to a flow of objects. A **Route** object is a specific type of Ember object that helps you setup and manage what happens when you visit that url route.

Let's say we want to show a list of users. First we would add the following route:

```coffee
App.Router.map ->
  @resource 'users'
```

Now when you visit `/users`, Ember will look for a `UsersRoute` object. Here's how that could look:

```coffee
App.UsersRoute = Ember.Route.extend

  model: -> @store.findAll 'user'
```

`model` is a function hook that's called upon entering a route. The result of the model function is then accessible by other objects.

The `store` is an Ember data construct that you go through when dealing with persisted records. `findAll` fetches all the records of the type you pass it. It returns a `DS.RecordArray` object, which is essentially an array of models.

## Route Hooks

Route objects are really all about using hooks to prepare data and perform any setup actions required for the controller.

`model` is just one of a series of hooks that are called when you enter a route. Here are a few more that you'll get to know, listed in order of when they are called.

```coffee
App.UsersRoute = Ember.Route.extend

  beforeModel: (transition) ->

  model: (params, transition) ->

  afterModel: (model, transition) ->

  activate: ->

  setupController: (controller, model) ->
    @_super(controller, model) # or @_super(arguments...)

  deactivate: ->
```

`beforeModel` is called immediately before `model` is called.

`model` we just went over.

`afterModel` is called after the model is resolved (i.e. either pulled down from the server or pulled out of the store).

`activate` is called after the all the model hooks have completed, meaning that the route is now active.

`setupController` is where you would do any controller setup. You get access to the controller itself as an argument. Note that if you implement `setupController` you will need to call super if your route is getting a model. If you don't super then the controller will not have the `model` property set.

`deactivate` is called when you exit the route. Note that it will not get called if you just change the model but stay on the same route. For example `deactivate` would not get called if you changed from `/users/1` to `/users/2`

## The Transition Object

The `transition` argument being passed into the route model hooks can be used to abort the transition. For example, say we have a HouseRoute and you don't like red houses:

```coffee
App.HouseRoute = Ember.Route.extend

  afterModel: (model, transition) ->
    transition.abort() if model.get('color') is 'red'
```

Here I'm using `afterModel`, because the model is resolved and I can ask for it's color property. If you abort, Ember will just go back to whatever route you came from. This can be handy for error checking, confirmation dialogs, and locking certain parts of your app depending on state.

## Grabbing Other Objects

Routes are the one place where we can reach across our app. Usually you do this give the controller the information it needs.

`@modelFor('routeName')` will return the current model for that route. You often use this to get the model of a route that that your current route is nested under.

`@controllerFor('controllerName')` will get that controller object. Sometimes you may want to get the model for that controller, in which case you would do `@controllerFor('controllerName').get('model')`.

Route objects are your friend. You'll find that all of their hooks are extremely handy when you start trying to do fancy things in your app.
