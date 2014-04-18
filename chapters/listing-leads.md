# Listing Leads

The first thing we'll do on the Ember side is list out all of our leads.

## Add a Route

Everything always starts with routes. Open up your Ember Router and create a leads resource with the path set to root:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.map ->
  @resource 'leads', path: '/'
```

## Create a Route Object

Now we need to pull in all of our lead records. You use route objects to obtain your models, so let's create a `LeadsRoute`:

```coffee
# app/assets/javascripts/routes/leads.js.coffee
App.LeadsRoute = Ember.Route.extend

  model: -> @store.findAll 'lead'
```

`model` is a hook that's called whenever the route is entered. The result of the model function is then available to the controller, view, and template.

To be sure this is working properly, simply visit your root route and look at the "Data" tab in the Ember Inspector. You should see all of your leads.

## Create the Template

Now that we have our leads we need to show them. Let's create a template:

```
# app/assets/javascripts/templates/leads.js.emblem
article#leads
  h1 Leads
    ul
      each lead in controller
        li= lead.fullName
```

We want to display a full name and we don't have that property yet. Let's add it to the model:

```coffee
# app/assets/javascripts/models/lead.js.coffee

fullName: ( -> 
  @get('firstName') + ' ' + @get('lastName')
).property('firstName', 'lastName')

```

Now refresh the page and you should see your leads listed out on the left. Cool!

## Sorting Leads

Our leads are not in any particular order. This is chaos! Let's sort them by name.

 You sort arrays of models by specifying `sortProperties` in the controller. We don't have a controller yet, so let's make one:

```coffee
# app/assets/javascripts/controllers/leads.js.coffee
App.LeadsController = Ember.ArrayController.extend
  sortProperties: ['firstName', 'lastName']
```

`sortProperties` simply takes an array of strings. These strings are the properties you want to sort by with the highest priority going first.

Note that I've made this an `ArrayController`. This is because the controller wraps an array of leads. Ember expects you to do this because `ArrayController` defines certain specific things like `sortProperties` that are not available to regular `Controller` instances.

Refresh the page and marvel at the beauty of your sorted leads.

Next we'll show each lead's data when when we click on it.
