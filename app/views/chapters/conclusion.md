# Conclusion

I hope that this tutorial provided a good introduction to the Ember framework, and maybe was even fun along the way. Please don't hesitate to [let me know](mailto:vic@vicramon.com) if anything is unclear or needs more explanation.

## Continuing Learning

If you want to keep learning I recommend reading through the [Ember Guides](http://emberjs.com/guides/) and the [Ember API Docs](http://emberjs.com/api/). They are very detailed and they do an excellent job explaining all the nuances of Ember.

After that, I think building your own application is the best way to learn.

## Take Home Work

A fun exercise could be to add functionlity to create a new lead in the app we just built. I'll get you started. Here's how I'd do the route:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.map ->
  @resource 'leads', path: '/', ->
    @route 'new'
    # etc...
```

## Extending this Tutorial

I'm considering adding more to the tutorial to help cover more Ember topics. If you'd like this then let me know. Also, if there's anything in particular that you think would be cool to add then let me know.

This tutorial is [on Github](https://github.com/vicramon/ember-tutorial-app), so you could even add a chapter yourself if you want to!

## Thanks

Thanks for giving my tutorial a read, and best of luck on your Ember journey!
