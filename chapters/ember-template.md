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

Emblem tries to parse the first word on each line as a helper or html tag, so if you want to immediately output plain text then use a pipe: `|`. Emblem parses everything after a pipe as a string.


## Outputting View Properties

The template also has access to view properties, but you must prefix calls to them with `view`. For example:

Handlebars:

```handlebars
Name: {{view.name}}
```

Emblem:

```emblem
| Name:
view.name
```

## If, Else, Unless

Handlebars gives you `if`, `else` and `unless`, with the rather limiting caveat that `if` and `unless` can only accept a single argument:

Handlebars:

```handlebars
{{#if isBirthday}}
  <div class="celebrate">Happy Birthday!</div>
{{#else}}
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

You can do nested `if` statements, but that starts to get ugly real quick.

This example really shows why I prefer Emblem. That's 112 characters for the Handlebars version and 57 for Emblem. That's almost one half the code! Less code, as long as it's readable, is always a win in my book.

## Loops

Handlebars offers two ways to loop through things. The first gives you access to the current object as `this`:

Handlebars:

```handlebars
{{#each users}}
  {{this.name}}
{{/each}}
```

In Emblem the call to `this` call is implicit. However, you still have access to `this` if you need it.

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

## Render, View, and Partial Helpers

Ember view
