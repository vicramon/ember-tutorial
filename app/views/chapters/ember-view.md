# Ember View

Views are one of the most fun and powerful objects in Ember.

You can think of a view as a wrapper for a template. It contains all the javascript you might want to execute on the template and all it manages the logic around attributes and class names.

## View Hooks

Like Routes, views have a series of hooks that you can use. Here are three of the more common ones you'll use, in order of when they would be called.

```coffee
App.UserView = Ember.View.extend

  willInsertElement: -> Em.K

  didInsertElement: -> Em.K

  willDestroyElement: -> Em.K
```

`willInsertElement` is called before the view is inserted into the DOM.

`didInsertElement` is called immediately after the view is inserted into the DOM. This is what you'll use most often for running any template-specific javascript.

`willDestroyElement` is called when view is about to be removed from the DOM. You can use this for any teardown you need to do.
