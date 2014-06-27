# Ember Template

Ember templates are simply [Handlebars](http://handlebarsjs.com/) files. I'm going to cover some of the basics of Handlebars and some of the unique Handlebars helpers that Ember provides.

In our app we're going to use [Emblem](http://emblemjs.com/), which compiles to Handlebars. To help aid your learning I will show these examples in both Handlebars and Emblem.

## Outputting Controller Properties

Views have direct access to controller properties. Just throw 'em in:

Handlebars:

```handlebars
Name: {{name}}
```

Emblem:

```emblem
| Name:
name
```

Emblem expects the first word on each line to be either a controller property, a Handlebars helper, or an html tag, so if you want to immediately output plain text then use a pipe: `|`. Emblem parses everything after a pipe as a string.


## Outputting View Properties

The template also has access to view properties, but you must prefix calls to them with `view`. For example:

Handlebars:

```handlebars
Name: {{view.someViewProperty}}
```

Emblem:

```emblem
| Name:
view.someViewProperty
```

## If, Else, Unless

Handlebars gives you `if`, `else` and `unless`. They only accept a single argument:

Handlebars:

```handlebars
{{#if isBirthday}}
  <div class="celebrate">Happy Birthday!</div>
{{else}}
  <div class="too_bad">Nope.</div>
{{/if}}
```

Emblem:

```emblem
if isBirthday
  .celebrate Happy Birthday!
else
  .too_bad Nope.
```

There are no `and`s or `or`s allowed in Handlebars. It is designed to contain zero application logic. If you need some kind of combined boolean then you need to do it in the controller.

You *can* use nested `if` statements, but that gets ugly quickly.

The above example really shows why I prefer Emblem. That's 112 characters for the Handlebars version and 57 for Emblem. That's almost one half the code! Less code, as long as it's readable, is always a win in my book.

## Loops

Handlebars offers two ways to loop through things. The first gives you access to the current object as `this`:

Handlebars:

```handlebars
{{#each users}}
  {{this.name}}
{{/each}}
```

In Emblem the call to `this` is implicit. However, you still have access to `this` if you need it.

```emblem
each users
  name
```

The second way to do loops is to name the object:

Handlebars:

```handlebars
{{#each user in users}}
  {{user.name}}
{{/each}}
```

Emblem:

```emblem
each user in users
  user.name
```

If you are iterating over records from an `ArrayController`, which is extremely common, you just pass it `controller`:

Emblem:

```emblem
each user in controller
  user.name
```

I think by now you may be getting the idea of Handlebars, so I'm going to switch just showing Emblem.

## Render, View, and Partial Helpers

Templates come with helpers that allow you to render another controller, view or template. This helps you reuse and compartmentalize logic.

The `render` helper calls a controller:

```
render 'user'
```

This will look for `UserController` and instantiate it. The controller will will then look for `UserView`, and a `user` template, as per the usual Ember Object Flow.

You can optionally pass the render method a model object:

```
render 'user' model
```

The `view` helper calls a view:

```
view 'user'
```

This would look for `UserView`, which would then look for a template named `user`. Using the `view` helpers means that Ember will **not** instantiate a controller, it will skip it.

The `partial` helper only calls a template:

```
partial 'user'
```

This would render the `user` template inside the current template. It would not use the controller or view. Unlike Rails, Ember does not expect your template to be prefixed with an underscore.

As you can see, the `render`, `view`, and `partial` helpers enable you to compartmentalize code as much as you need. If you only need to show additional markup, just use `partial`. If you need markup with some javascript attached, use `view`. If you need markup that has access to its own set of properties and actions, then you'll need to use `render`.

The Ember docs provide a great [comparison table](http://emberjs.com/guides/templates/rendering-with-helpers/#toc_comparison-table) that helps explain how these helpers differ.

## Actions

You can specify what are called **actions** on any element in a template. Actions will call a function in the controller of the same name:

```
h1 click="tickle" Tickle Me
```

This would call a `tickle` method in the controller when a user clicks on the `h1`. The method must be defined inside an `actions` object:

```coffee
App.MyController = Ember.Controller.extend

  actions:
    tickle: -> alert('hahaha')
```
```javascript
App.MyController = Ember.Controller.extend({

  actions: {
    tickle: function() { alert('hahaha') }
  }

})
```

## The Link-To Helper

Ember provides a `link-to` helper that will transition you to a different route. You pass it the name of the route and any models that you need to send along.

Say you had an array controller that gave you a list of users, and you wanted to provide a link to each one. Here's how you'd do that:

```
each userRecord in controller
  link-to 'user' userRecord
    userRecord.name
```

Ok, now that we've covered Routes, Controllers, Views and Templates, we can actually build something!
