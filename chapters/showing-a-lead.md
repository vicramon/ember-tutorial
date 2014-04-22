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
# app/assets/javascripts/routes/lead.js.coffee
App.LeadRoute = Ember.Route.extend

  model: (params) -> @store.find 'lead', params.id
```

## Create the Template

Our template will show the information about our lead.

```
/* app/assets/javascripts/templates/lead.js.emblem */
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

The single quote `'` leaves a trailing whitespace after that line.

## Link to Each Lead

Open your leads template so we can create a link to each lead:

```
/* app/assets/javascripts/templates/leads.js.emblem */
article#leads
  h1 Leads
  ul
    each lead in controller
      = link-to 'lead' lead tagName="li"
        = lead.fullName

= outlet
```

Two things are happening here. 

First, our `li` became a `link-to`. We passed it `tagName=li` so that the html element will remain an `li`. `tagName` is simply a property that we are providing to the view.

Second, we've placed an `outlet` tag at the end of the template. Since the lead route is nested under leads, all of it's content will be output in the outlet of leads. In this case the markup is on the same level in the DOM so this doesn't present a problem. If you had a situation where you needed to output the content elsewhere on the page you could use the [renderTemplate](http://emberjs.com/api/classes/Ember.Route.html#method_renderTemplate) method in the route to specify an outlet somewhere else.

One nice thing about the `link-to` helper is that it automatically adds a class of `active` to the element when you are on the route it's linking to. My css takes advantage of this to highlight the currently selected lead.

Now refresh the page and click on a lead. You should see that lead's information show up on the right, and it should be snappy.

Next we'll create form elements and save data.
