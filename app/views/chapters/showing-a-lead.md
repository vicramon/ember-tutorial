# Showing a Lead

When we click on a lead we should see its data populated on the right. Here's how we do that.

## Add a Route

First add a route to show a specific lead:

```coffee
# app/assets/javascripts/router.js.coffee
@resource 'lead', path: '/lead/:id'
```

## Create a Route Object

We need a Route Object to pull down our specific lead. We have access to our dynamic segment `/:id` through the `params` object, which `model` takes in as an argument.

The `@store.find` function gets a record by its id.

```coffee
App.LeadRoute = Ember.Route.extend

  model: (params) -> @store.find 'lead', params.id
```

## Create a Template

Our template will show the information about our lead.

```
# app/assets/javascripts/templates/lead.js.emblem
article#lead
  h1= model.fullName

  p
    ' Name:
    = model.fullName

  p
    ' Email:
    = model.email

  p
    ' Phone:
    = model.phone
```
