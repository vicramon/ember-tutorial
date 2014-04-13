# Listing Leads

The first thing we'll do on the Ember side is list out all of our leads.

Let's start at the start: routes. Open up your Ember Router and create a leads resource with the path set to root:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.map ->
  @resource 'leads', path: '/'
```

Now we need to pull in all of our lead records. You use route objects to obtain your models, so let's do create a `LeadsRoute`:

```coffee
# app/assets/javascripts/routes/leads.js.coffee
App.LeadsRoute = Ember.Route.extend

  model: -> @store.findAll 'lead'
```

`model` is a hook that's called whenver the route is entered. The result of the model function is then available to the controller, view, and template.

To be sure this is working properly, simply visit your root route and look at the "Data" tab in the Ember Inspector. You should see all of your leads.

Now that we have our leads we need to show them. Let's create a template:

```
# app/assets/javascripts/templates/leads.js.emblem
article#leads
  h1 Leads
    ul
      each lead in controller
        li= lead.fullName
```

We want to display a full name and we don't have that yet. Let's add it to the model:

```coffee
# app/assets/javascripts/models/lead.js.coffee

fullName: ( -> 
  @get('firstName') + ' ' + @get('lastName')
).property('firstName', 'lastName')

```

Now refresh the page and you should see your leads listed out on the left. Cool! Now we need to show each lead's data when when we click on it.
