# Creating the Layout

I built some UI for this project which we can use. All you need to do is follow along with the same markup and your project will turn out looking like mine.

We need to create our layout so we can build stuff inside it. Let's do that now.

## Rails Layout

You shouldn't have to change your Rails layout, but for reference here's what mine looks like in haml:

```haml
!!!
%html(lang="en-US")
  %head
    %title Ember CRM
    = stylesheet_link_tag "application"
    = javascript_include_tag "application"
    = csrf_meta_tags

  %body
    #ember-app
    = yield

  %footer
```

This is fairly standard. There are other UI elements we'll want to add in a momenet.

## Rails View

My root rails view is actually empty, but it needs to exist, otherwise Rails will complain.

```haml
-# app/views/home/index.html.haml
```

## Ember Layout

Now we face an interesting question, which you will face multiple times as you build with Ember inside Rails. Should we build it in Ember or in Rails? This really depends.

If your Ember app is just on a single page, then it might make sense to build the layout in Rails so that it can be used on other non-Ember pages. But if your Ember app truly has multiple pages, and the layout links to these other Ember pages, then it makes sense to do it in Ember.

In our app we only have a single page with Ember, so we could build our layout in Rails and be just fine. However, this tutorial is all about learning Ember, so let's do it in Ember anyways.

Ember always renders the `application` template, so let's make it:

```
# app/assets/javascripts/templates/application.emblem.js
header
  article
    .logo
      h1
        = link-to 'lead' | Ember CRM

section#main
  = outlet
```

The pipe operator `|` in Emblem signifies the end of that particular element, so you can start nesting things inside it on the same line. In this case we want `Ember CRM` to be inside the `link-to`, so this keeps things on a single line while giving us the proper format.

Now if you refresh you should see the orange Ember CRM banner across the top. Next we'll be dealing with getting and showing data.
