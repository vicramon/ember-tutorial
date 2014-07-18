# Creating the Layout

We need to create our layout so we can build stuff inside it. Let's do that now.

## Rails Layout

Your Rails layout should look like this to start:

```erb
<!-- app/views/layouts/application.html.erb -->
<!DOCTYPE html>
<html>
  <head>
    <title>Ember CRM</title>
    <%= stylesheet_link_tag    'application'  %>
    <%= javascript_include_tag 'application' %>
    <%= csrf_meta_tags %>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
```

Ember will insert itself at the end of your body tag by default. However, you can tell Ember to render into a specific element. Let's do that:

First, create a div with the id `ember-app`.

```erb
<body>
  <%= yield %>
  <div id="ember-app"></div>
</body>
```

<p class="coffeescript">
Now, open up <code>application.js.coffee</code> and tell Ember that the <code>rootElement</code> is <code>ember-app</code>:
</p>

<p class="javascript">
Now, open up <code>application.js</code> and tell Ember that the <code>rootElement</code> is <code>ember-app</code>:
</p>

```coffee
window.App = Ember.Application.create(rootElement: '#ember-app')
```
```javascript
App = Ember.Application.create({rootElement: '#ember-app'})
```

Now Ember will render everything inside the `ember-app` div.

## Rails View

The Rails view you created for Hello World should still exist but remain empty.

## Ember Layout

Now we face an interesting question. You will face questions like this often as you build with Ember inside Rails. Should we build the layout in Ember or in Rails? This really depends.

If your Ember app is just on a single page, then it might make sense to build the layout in Rails so that it can be used on other non-Ember pages. But if your Ember app truly has multiple pages, and the layout links to these other Ember pages, then it makes sense to do it in Ember.

In our app we only have a single page with Ember, so we could build our layout in Rails and be just fine. However, this tutorial is all about learning Ember, so let's do it in Ember anyway.

Ember always renders the `application` template, so we'll use that for the layout:

```
// app/assets/javascripts/templates/application.js.emblem
header
  article
    .logo
      h1
        a href="#" Ember CRM

section#main
  = outlet

footer
```

Now if you refresh you should see the orange Ember CRM banner across the top. Next we'll be dealing with getting and showing data.
