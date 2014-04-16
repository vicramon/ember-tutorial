# Ember Controller

Controllers in Ember function much like normal Ember Objects with a couple of exceptions. First, let's look at the three types of controllers.

## A Story of Three Controllers

Ember provides three types of controllers to you: `Controller`, `ObjectController`, and `ArrayController`. You use `ObjectController` whenever that controller's route is for a single model. Use `ArrayController` when the route is for a list of models. And finally use `Controller` when the route isn't fetching models at all.

## Properties, Observers, and Functions

Controllers don't have any specific hooks that are called upon entering them. You can use `init` if you really need to, but you shouldn't. All setup work should be done in the route.

So what's left? Properties, observers, and functions. These are your bread and butter.

```coffee
# app/assets/javascripts/controllers/user.js.coffee
App.UserController = ObjectController.extend

  someFunction: -> alert('such function')

  someProperty: ( ->
    if @get('model.firstName') is "Joe"
      "Hey Joe"
    else
      "You're not Joe"
  ).property('model.firstName')

  someObserver: ( ->
    alert "I see you changed your name, #{@get('model.firstName')}"
  ).observes('model.firstName')
```

You can put as many of these as you like in your controller. Properties will be available to the template automatically.

## Executing Template Actions

Another major use for controllers is handling actions from templates. For example, a template may have a submit button, or a delete link. These actions could be handled like so:

```coffee
# app/assets/javascripts/controllers/user.js.coffee
App.UserController = ObjectController.extend

  actions:
    deleteUser: -> @get('model').deleteRecord()

    saveChanges: -> @get('model').save()
```

All action handlers must go inside an `actions` construct in the controller. This is an Ember convention to help keep your code organized.
