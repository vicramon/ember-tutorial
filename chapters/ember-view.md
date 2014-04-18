# Ember View

Views are one of the most fun and powerful objects in Ember.

You can think of a view as a wrapper for a template. It contains all the javascript you might want to execute on the template and all it manages the logic around attributes and class names.

## Talking to the Controller

The view can get the controller through `@get('controller')`. The view does not have the current model by default, so to get the model you'll have to do `@get('controller.model')`. To get a property on the controller you would do `@get('controller.myProperty')`.

## View Hooks

Like Routes, views have a series of hooks that you can use. Here are three of the more common ones you'll use, in order of when they are called.

```coffee
App.UserView = Ember.View.extend

  willInsertElement: -> Em.K

  didInsertElement: -> Em.K

  willDestroyElement: -> Em.K
```

`willInsertElement` is called before the view is inserted into the DOM.

`didInsertElement` is called immediately after the view is inserted into the DOM. This is what you'll use most often for running any template-specific javascript. It's also helpful for debugging -- you can place a `debugger` or `console.log` in didInsertElement to get more insight if things aren't working.

`willDestroyElement` is called when view is about to be removed from the DOM. You can use this for any teardown you need to do.

## Defining the Element

When I said views wrap templates, I meant it quite literally. A view will by default wrap the template in a div with a generated ember id, like `#ember45`.

We can customize this wrapping element very easily.

```coffee
App.UserView = Ember.View.extend
  tagName: 'article'
  classNames: ['myClass', 'anotherClass']
```

`tagName` specifies the html element that the view uses.

`classNames` lets you add any css class names you want on the element.

If you *really* need to set an id on an element, you can use `elementId: 'myId'`, but I recommend avoiding that if you can. Views are designed to be reused, so you may have more than one instance of the same view present on the page, and id's are meant for single elements.

## Class Bindings

Now comes the fancy stuff. What if you want to dynamically assign class names? Ember's got your back.

```coffee
App.AnimalView = Ember.View.extend
  classNameBindings: ['active']

  active: Em.computed.alias 'controller.model.isActive'
```

This is the simplest version of class name bindings. A class name of `active` will appear if the `active` property returns true, otherwise it won't appear.

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

`classNameBindings` will look for the property you named and execute it. In this case, since the return value is not a boolean, it will be used as a class name. If the return value is undefined then it won't do anything. Here, a class of `meow` will be applied if the model is a cat, and `woof` if it's a dog.

There's actually an abbreviated version of this that you can optionally use:

```coffee
App.AnimalView = Ember.View.extend
  classNameBindings: ['isCat:moew:woof']

  isCat: ( -> 
    @get('model.kind') is "cat"
  ).property('model.kind')
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

This is the simplest case of attribute bindings. Ember will create an attribute with the name of the property (`src`), and the value of the attribute will be the return value of the property.

There are often cases where you want the property to have a different name than the attribute. In this case just do `propertyName:attributeName` like so:

```coffee
App.ImageView = Ember.View.extend
  tagName: 'img'
  attributeBindings: ['srcProperty:src']

  srcProperty: Em.computed.alias 'controller.model.src'
```

Now there will be a `src` attribute that's set to the result of `srcProperty`.

## Specifying a Different Template

A `UserView` will look for a `user` template, but if you want to use a different one you can specify `templateName`:

```coffee
App.UserView = Ember.View.extend
  templateName: 'someOtherTemplate'
```

## Getting the Current Element

Often times you'll need the current element. It's available to you as `element`, like this:

```coffee
App.UserView = Ember.View.extend

  didInsertElement: ->
    console.log @get('element')
```

That would log the plain element.

Need to get the element and run some jQuery on it? Yo could do `$(@get('element'))`, but that's pretty long. Ember gives you a shortcut: `@$()`.

```coffee
App.UserView = Ember.View.extend

  didInsertElement: ->
    @$('.someClass').fadeOut()
```

This would look for `.someClass` inside your current view and fade it out.

## Handling Actions

As I mentioned in the Ember Controller chapter, template actions always go straight to the controller. However, UI interactions like click, doubleClick, and mouseEnter are handled on the view.

Just define a function with the event name and it will get called when it occurs:

```coffee
App.UserView = Ember.View.extend

  click: -> console.log 'clicked'
  mouseEnter: -> console.log 'mouse entered'
  mouseLeave: -> console.log 'mouse left'
```

The event listeners will be applied to the entire view, so clicking anywhere inside it would trigger the click function.

A full list of view events can be found [here](http://emberjs.com/api/classes/Ember.View.html#toc_event-names) in the Ember docs.

That's it for views. Next I'll cover templates. It's the last chapter before we start actually building stuff, so hang in there!
