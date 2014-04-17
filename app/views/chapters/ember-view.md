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

`didInsertElement` is called immediately after the view is inserted into the DOM. This is what you'll use most often for running any template-specific javascript.

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
  classNameBindings: ['soundClass']

  soundClass: ( ->
    if @get('model.kind') is "cat"
      "meow"
    else
      "woof"
  ).property('model.kind')
```

`classNameBindings` will look for the property you named and execute it, and the return value will be used as a class name. If the return value is undefined then it won't do anything. In this case, a class of `meow` will be applied if the model is a cat, and `woof` if it's a dog.

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

Attribute bindings work similarly, with a couple of differences. Let's say we're trying to show an image, and assume that the model has an attribute called `src`:

```coffee
App.ImageView = Ember.View.extend
  tagName: 'img'
  attributeBindings: ['src']

  src: Em.computed.alias 'controller.model.src'
```

This is the simplest case of attribute bindings. Ember will create an attribute with the name of the property (`src`), and the value wil be the result of the property.
