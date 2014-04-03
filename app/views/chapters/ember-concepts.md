# Ember Concepts

Before we dive into building out the app I want to cover some core Ember concepts. I think some of these are better learned up front to provide a foundation for what we're about to code.

## The Ember Object

Ember implements its own object system. The base object is called Ember.Object. All of the other objects in Ember extend Ember.Object. You can see all of Ember.Objects methods available to you [in the Ember docs](http://emberjs.com/api/classes/Ember.Object.html).

While most of the time you will be using an object like Ember.Controller or Ember.View, you can also use Ember.Object itself. Here's how you could use it:

You can create a basic object like this:

```coffee
user = Ember.Object.create()
```

Initialize it with properties by just passing them to create:

```coffee
user = Ember.Object.create(firstName: 'Sam', lastName: 'Smith')
```

You can get a property from the object by calling `.get` on it and passing the string name of the property:

```coffee
user = Ember.Object.create(firstName: 'Sam', lastName: 'Smith')
user.get('firstName') == 'Sam' #=> true
user.get('lastName') == 'Sam' # true
```

Inquire about the object with `.toString()`. In this case we see that it's just Ember.Object.

```coffee
user = Ember.Object.create()
user.toString() # <Ember.Object:ember{objectId}>
```

## Defining Objects

So far we've just been using Ember.Object. What if we want to create our own object? You can do that like this:

```coffee
App.User = Ember.Object.extend()
```

Boom! Now you can instantiate a user like so:

```coffee
user = App.User.create()
```

Note that I'm putting the user on `App`. Ember needs to place all of the app data inside a variable, and people typically use `App`. So when you define some kind of Object in ember you always want to have it on `App`.

Now what we've done is great and all, but we probably want to add things to our User object. Let's do it!

Objects can have three types of things inside them: properties, functions, and observers.

## Properties

Here's how you could define a property:

```coffee
App.User = Ember.Object.extend
  isGreat: true
  temperature: 98.6
  favoriteDirector: 'Tarantino'
```

`isGreat`, `temperature`, and `favoriteDirector` would now be accessible with `.get`. These are the basic versions of Ember properties. We can also create computed properties that actually do some work and call other properites:

```coffee
App.User = Ember.Object.extend

  fullName: ( ->
    @get('firstName') + ' ' + @get('lastName')
  ).property('firstName', 'lastName')


```

Let's dissect this.

First, we specify the property name with `fullName:`.

Second, we pass it a function that will return the value we want. We can get at other properties in our object by doing `this.get('propertyName')`, or in CoffeeScript, `@get('propertyName')`.

Third, we call `.property()` on our function to tell Ember that it's a computed property.

Finally, we have to tell `property()` which other properties this property depends on. It expects a list of the property names as strings. In this case, `fullName` should change any time `firstName` or `lastName` changes, so it neds to watch both of them.

# Functions

Functions are quite simple. Example:

```coffee
App.User = Ember.Object.extend

  showMessage: (message) -> alert(message)

  showName: -> @showMessage(@get('fullName'))


```

Our `showMessage` function takes one argument: the message we want to alert. The `showName` function calls the `showMessage` function with the `fullName` of our user (assuming we've implemented the `fullName` property).

Here's how you actually call a function:

```coffee
user = App.User.create()
user.showMessage('omg this works!')
```

## Observers

Observers are functions that fire whenever the any of thethings they observe change. They look like propertyies, but end with `observes()` instead of `property()`

```coffee
App.User = Ember.Object.extend

  weightChanged: ( ->
    alert('yikes')
  ).observes('weight')


```

The above code would fire an alert saying 'yikes' whenver the weight property on this user changes. You can observe as many things as you'd like:

```coffee
App.User = Ember.Object.extend

  bodyObserver: ( ->
    alert("You've changed. I don't even know you anymore.")
  ).observes('weight', 'height')


```

## Extend Existing Objects

The Ember Object system is really great. It makes it easy to write modular, reusable code.

You can extend any existing object in your app like this:

```coffee
App.Animal = Ember.Object.extend
  likesFood: true

App.Human = App.Animal.extend()

human = App.Human.create()

human.get('likesFood') # true
```

Properties, functions, and observers in the child object will override those in the parent:

```coffee
App.Bird = App.Animal.extend
  likesFood: false

bird = App.Bird.create()
bird.get('likesFood') # false
```

You can even extend multiple objects:

```coffee
App.One = Ember.Object.extend()
App.Two = Ember.Object.extend()

App.Three = App.One.extend(App.Two)
# or
App.Three = Ember.Object.extend(App.One, App.Two)
```

Extending objects is a pattern you will use all the time while developing in Ember. You can use it to extract out common functionality or pull in functionality from some other part of your app or another Ember object.

## Routing

## Routes

## Controllers

## Views

## Templates
