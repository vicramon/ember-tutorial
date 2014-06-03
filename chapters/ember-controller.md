# Ember Controller

Controllers handle non-persisted logic related to a specific piece of UI. They typically wrap a model or an array of models. You can put functions, properties, and observers on controllers. They function much like normal Ember Objects with a couple of exceptions.

First we'll look at the three different types of controllers.

## A Story of Three Controllers

Ember provides you with three types of controllers: `ObjectController`, `ArrayController`, and `Controller`. You use `ObjectController` whenever that controller's route fetches a single model. Use `ArrayController` when the route fetches an array of models. And finally use `Controller` when the route isn't fetching any models at all.

## Properties, Observers, and Functions

Controllers don't have any specific hooks that are called upon entering them. You can use `init` if you really need to, but you shouldn't. All setup work for a controller should be done in the route, usually in the route's `setupController` hook.

So what's left? Properties, observers, and functions. These are your bread and butter.

```coffee
# app/assets/javascripts/controllers/user.js.coffee
App.UserController = ObjectController.extend

  someFunction: -> alert('so functional')

  someProperty: ( ->
    if @get('model.firstName') is "Gregory"
      "Hey Gregory"
    else
      "Hey, you're not Gregory"
  ).property('model.firstName')

  someObserver: ( ->
    alert "You changed your name? I don't really see you as a #{@get('model.firstName')}."
  ).observes('model.firstName')
```
```javascript
// app/assets/javascripts/controllers/user.js
App.UserController = ObjectController.extend({

  someFunction: function() { alert('so functional') },

  someProperty: function() {
    if (this.get('model.firstName') == "Gregory") {
      return "Hey Gregory"
    } else {
      return "Hey, you're not Gregory"
    }
  }.property('model.firstName'),

  someObserver: function() {
    alert("You changed your name? I don't really see you as a " + this.get('model.firstName'));
  }.observes('model.firstName')

})
```

You can put as many of these as you like in your controller. Any controller properties will be available to the template and view.

## Mixins

If you find yourself duplicating a lot of logic you can extract your code to an `Ember.Mixin` and have your controller extend it like so:

```coffee
# app/assets/javascripts/mixins/excited.js.coffee
App.Excited = Ember.Mixin.create
  levelOfExcitement: "I'm so freaking excited right now!!!"

# app/assets/javascripts/controllers/user.js.coffee
App.UserController = ObjectController.extend App.Excited,
  # your controller code

```
```javascript
// app/assets/javascripts/mixins/excited.js
App.Excited = Ember.Mixin.create({
  levelOfExcitement: "I'm so freaking excited right now!!!"
})

// app/assets/javascripts/controllers/user.js
App.UserController = ObjectController.extend(App.Excited, {
  // your controller code
})
```

Now `UserController` would have the `levelOfExcitement` property. Also notice that mixins are created with `.create` rather than `.extend`.

## Executing Template Actions

Another major use for controllers is handling actions from templates. For example, a template may have a submit button or a delete link. These actions would be handled like so:

```coffee
# app/assets/javascripts/controllers/user.js.coffee
App.UserController = ObjectController.extend

  actions:

    deleteUser: -> @get('model').destroyRecord()

    saveChanges: -> @get('model').save()
```
```javascript
// app/assets/javascripts/controllers/user.js
App.UserController = ObjectController.extend({

  actions: {

    deleteUser: function() { this.get('model').destroyRecord() },

    saveChanges: function() { this.get('model').save() }

    }
})
```

All action handlers must go inside an `actions` object in the controller. This is an Ember convention to help keep your code organized.
