# Listing Leads

The first thing we'll do on the Ember side is list out all of our leads.

## Add a Route

Everything always starts with routes. Open up your Ember Router and create a leads resource with the path set to root:

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.map ->
  @resource 'leads', path: '/'
```
```javascript
// app/assets/javascripts/router.js
App.Router.map(function() {
  this.resource('leads', { path: '/' })
})
```

## Create a Route Object

Next we need to fetch all lead records. Let's create a `LeadsRoute`:

```coffee
# app/assets/javascripts/routes/leads.js.coffee
App.LeadsRoute = Ember.Route.extend

  model: -> @store.findAll 'lead'
```
```javascript
// app/assets/javascripts/routes/leads.js
App.LeadsRoute = Ember.Route.extend({
  model: function() { return this.store.findAll('lead') }
})
```

Remember that `model` is a hook that's called whenever the route is entered. The result of the model function is then available to the controller, view, and template.

To be sure this is working properly, simply visit your root route and look at the "Data" tab in the Ember Inspector. You should see all of your leads.

## Create the Template

Now that we have our leads we need to show them. Let's create a template:

```
// app/assets/javascripts/templates/leads.js.emblem
article#leads
  h1 Leads
  ul
    each lead in controller
      li= lead.firstName
```

Now refresh the page and you should see your leads' listed on the left. Cool, right!?

## Show Full Names

Let's create a property to display the leads' full names. Open the lead model and add it:

```coffee
# app/assets/javascripts/models/lead.js.coffee
fullName: ( ->
  @get('firstName') + ' ' + @get('lastName')
).property('firstName', 'lastName')
```
```javascript
// app/assets/javascripts/models/lead.js
fullName: function() {
  return this.get('firstName') + ' ' + this.get('lastName')
}.property('firstName', 'lastName')
```

Then modify the template:

```
li= lead.fullName
```

## Sorting Leads

Our leads are not in any particular order. This is chaos! Let's sort them by name.

You can sort arrays of models by specifying `sortProperties` in the controller. We don't have a controller yet, so let's make one:

```coffee
# app/assets/javascripts/controllers/leads.js.coffee
App.LeadsController = Ember.ArrayController.extend
  sortProperties: ['firstName', 'lastName']
```
```javascript
// app/assets/javascripts/controllers/leads.js
App.LeadsController = Ember.ArrayController.extend({
  sortProperties: ['firstName', 'lastName']
})
```

`sortProperties` takes an array of strings. These strings are the properties you want to sort by with the highest priority first.

Note that I've made this controller an `ArrayController`. If you remember from the Controllers chapter, this is because the controller wraps an array of leads. Ember expects you to do this because `ArrayController` defines certain things like `sortProperties` that are not available on regular `Controller` instances.

Refresh the page and marvel at the beauty of your sorted leads.

Next we'll show each lead's data when when we click on it.
