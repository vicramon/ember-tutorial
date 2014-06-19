# Ember View

The View is one of the most powerful objects in Ember. You can think of a view as a wrapper for a template. It contains all the javascript you might want to execute on the template and manages the logic around attributes and class names.

## Talking to the Controller

The view can get the controller through `this.get('controller')`. The view does not have the current model by default, so to get the model you'll have to do `this.get('controller.model')`. To get a property on the controller you would do `this.get('controller.myProperty')`.

## View Hooks

Like Routes, views have a series of hooks that you can use. Here are three of the more common ones you'll use, in order of when they are called.

```coffee
App.UserView = Ember.View.extend

  willInsertElement: ->

  didInsertElement: ->

  willDestroyElement: ->
```
```javascript
App.UserView = Ember.View.extend({

  willInsertElement: function() {  },

  didInsertElement: function() {  },

  willDestroyElement: function() {  }
})
```

`willInsertElement` is called before the view is inserted into the DOM.

`didInsertElement` is called immediately after the view is inserted into the DOM. This is what you'll use most often for running any template-specific javascript. It's also helpful for debugging -- you can place a `debugger` or `console.log` in didInsertElement to get more insight if things aren't working.

`willDestroyElement` is called when view is about to be removed from the DOM. You can use this for any teardown you need to do.

## Computed Aliases

This isn't related specifically to views, but I'm about to use a computed alias so I need to explain what they are. Computed aliases are essentially shorthand for grabbing properties from other objects.

You just pass `Em.computed.alias` the string name of the property you want to look up. (`Em.` is an alias for `Ember.`). This will look up the property and watch it at the same time. For example:

```coffee
App.MyController = Ember.Controller.extend
  name: 'Zelda'

App.MyView = Ember.View.extend

  # this is kind of lame
  name: ( ->
    @get('controller.name')
  ).property('controller.name')

  # instead, use a computed alias
  name: Em.computed.alias 'controller.name'
```
```javascript
App.MyController = Ember.Controller.extend({
  name: 'Zelda'
})

App.MyView = Ember.View.extend({

  // this is kind of lame
  name: function() {
    this.get('controller.name')
  }.property('controller.name'),

  // instead, use a computed alias
  name: Em.computed.alias('controller.name')

})
```

Ember provides a whole variety of computed functions that let you create these kind of shorthand properties. For example, `Em.computed.not` returns the inverse of a boolean value. You can view the full list in the [Ember API](http://emberjs.com/api/).

## Defining the Element

When I said views wrap templates, I meant it quite literally. A view will by default wrap the template in a `div` with a generated ember id, like `ember45`.

We can customize this wrapping element very easily.

```coffee
App.UserView = Ember.View.extend
  tagName: 'article'
  classNames: ['myClass', 'anotherClass']
```
```javascript
App.UserView = Ember.View.extend({
  tagName: 'article',
  classNames: ['myClass', 'anotherClass']
})
```

`tagName` specifies the html element that the view uses.

`classNames` lets you add any css class names you want on the element.

If you *really* need to set an id on an element, you can use `elementId: 'myId'`, but I recommend avoiding that if you can. Views are designed to be reused, so you may have more than one instance of the same view present on the page, and id's are meant for single elements.

## Class Bindings

Now comes the fancy stuff. What if you want to dynamically assign class names? Ember has got your back.

```coffee
App.AnimalView = Ember.View.extend
  classNameBindings: ['active']

  active: Em.computed.alias 'controller.model.isActive'
```
```javascript
App.AnimalView = Ember.View.extend({
  classNameBindings: ['active'],
  active: Em.computed.alias('controller.model.isActive')
})
```

`classNameBindings` will look for the property you named and execute it. In this case a class name of `active` will appear if the `active` property returns true, otherwise it won't appear.

But what if you need more control than that? Try this:

```coffee
App.AnimalView = Ember.View.extend
  classNameBindings: ['soundClass']

  soundClass: ( ->
    if @get('model.kind') is "cat"
      "meow"
    else
      "woof"
  ).property('model.kind')
```
```javascript
App.AnimalView = Ember.View.extend({
  classNameBindings: ['soundClass']

  soundClass: function() {
    if (this.get('model.kind') == "cat") {
      return "meow"
    } else {
      return "woof"
    }
  }.property('model.kind')
```

In this case, since the return value is not a boolean, the return value will be used as the class name. If the return value is undefined then it won't do anything. Here, a class of `meow` will be applied if the model is a cat, and `woof` if it's a dog.

There's actually an abbreviated version of this that you can use:

```coffee
App.AnimalView = Ember.View.extend
  classNameBindings: ['isCat:meow:woof']

  isCat: Em.computed.equal 'model.kind', 'cat'
```
```javascript
App.AnimalView = Ember.View.extend({
  classNameBindings: ['isCat:meow:woof'],
  isCat: Em.computed.equal('model.kind', 'cat')
})
```

The first value after the colon will be applied if the property returns true, otherwise the second value will be applied. Note that you can omit the second value if only want a class to be applied in the first case.

## Attribute Bindings

Attribute bindings work similarly, though with some differences. Let's say we're trying to show an image, and assume that the model has an attribute called `src`:

```coffee
App.ImageView = Ember.View.extend
  tagName: 'img'
  attributeBindings: ['src']

  src: Em.computed.alias 'controller.model.src'
```
```javascript
App.ImageView = Ember.View.extend({
  tagName: 'img',
  attributeBindings: ['src'],
  src: Em.computed.alias('controller.model.src')
})
```

This is the simplest case of attribute bindings. Ember will create an attribute with the name of the property (`src`), and the value of the attribute will be the return value of the property.

There are often cases where you want the property to have a different name than the attribute. In this case just do `propertyName:attributeName` like so:

```coffee
App.ImageView = Ember.View.extend
  tagName: 'img'
  attributeBindings: ['srcProperty:src']

  srcProperty: Em.computed.alias 'controller.model.src'
```
```javascript
App.ImageView = Ember.View.extend({
  tagName: 'img',
  attributeBindings: ['srcProperty:src'],
  srcProperty: Em.computed.alias('controller.model.src')
})
```

Now there will be a `src` attribute that's set to the result of `srcProperty`.

## Specifying a Different Template

A `UserView` will look for a `user` template, but if you want to use a different one you can specify `templateName`:

```coffee
App.UserView = Ember.View.extend
  templateName: 'someOtherTemplate'
```
```javascript
App.UserView = Ember.View.extend({
  templateName: 'someOtherTemplate'
})
```

## Getting the Current Element

Often times you'll need the current element. It's available to you as `element`, like this:

```coffee
App.UserView = Ember.View.extend

  didInsertElement: ->
    console.log @get('element')
```
```javascript
App.UserView = Ember.View.extend({

  didInsertElement: function() {
    console.log this.get('element')
  }

})
```

That would log the plain element.

Need to get the element and run some jQuery on it? You could do `$(this.get('element'))`, but that's pretty long. Ember gives you a shortcut: `this.$()`.

```coffee
App.UserView = Ember.View.extend

  didInsertElement: ->
    @$('.someClass').fadeOut()
```
```javascript
App.UserView = Ember.View.extend({

  didInsertElement: function() {
    this.$('.someClass').fadeOut()
  }

})
```

This would look for `.someClass` inside your current view and fade it out.

## Handling Events

UI events like click, doubleClick, and mouseEnter are accessible by the view. Just define a function with the event name and it will get called when the event occurs:

```coffee
App.UserView = Ember.View.extend

  click: -> console.log 'clicked'
  mouseEnter: -> console.log 'mouse entered'
  mouseLeave: -> console.log 'mouse left'
```
```javascript
App.UserView = Ember.View.extend({
  click: function() { console.log('clicked') },
  mouseEnter: function() { console.log('mouse entered') },
  mouseLeave: function() { console.log('mouse left') }
})
```

The event listeners will be applied to the entire view, so clicking anywhere inside it would trigger the click function.

A full list of view events can be found in the [Ember docs](http://emberjs.com/api/classes/Ember.View.html#toc_event-names).

That's it for views. Next I'll cover templates. It's the last chapter before we start actually building stuff, so hang in there!
