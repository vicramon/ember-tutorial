# Showing a Lead

When we click on a lead we should see it appear on the right. Let's do it.

## Add a Resource

First we'll need to add a resource to show a specific lead. Since we want the list of leads to still remain present on the page when we show a lead, this resource should be nested under the leads resource.

```coffee
# app/assets/javascripts/router.js.coffee
App.Router.map ->
  @resource 'leads', path: '/', ->
    @resource 'lead', path: '/leads/:id'
```
```javascript
// app/assets/javascripts/router.js
App.Router.map(function() {
  this.resource('leads', { path: '/' }, function() {
    this.resource('lead', { path: '/leads/:id' });
  })
})
```

<p class="coffeescript">
Make sure to add <code>, -></code> after the leads resource.
</p>

## Create a Route Object

We need a Route Object to pull down our specific lead.

```coffee
# app/assets/javascripts/routes/lead.js.coffee
App.LeadRoute = Ember.Route.extend

  model: (params) -> @store.find 'lead', params.id
```
```javascript
// app/assets/javascripts/routes/lead.js
App.LeadRoute = Ember.Route.extend({

  model: function(params) { return this.store.find('lead', params.id) }

})
```

We have access to `id` through the `params` argument.

The `this.store.find` function gets a record by its id. It actually returns a [promise](http://emberjs.com/api/classes/Ember.RSVP.Promise.html) which Ember will attempt to resolve.

## Create the Template

Our template will show the information about our lead.

```
// app/assets/javascripts/templates/lead.js.emblem
article#lead
  h1= model.fullName

  p
    ' Name:
    model.fullName

  p
    ' Email:
    model.email

  p
    ' Phone:
    model.phone
```

The single quote `'` leaves a trailing whitespace after the line.

## Link to Each Lead

Open your leads template so you can create a link to each lead:

```
// app/assets/javascripts/templates/leads.js.emblem
article#leads
  h1 Leads
  ul
    each lead in controller
      link-to 'lead' lead tagName="li"
        lead.fullName

outlet
```

Two things are happening here.

First, our `li` became a `link-to`. We passed it `tagName="li"` so that the html element will be an `li`. You can set any property on a view this same way, `propertyName="value"`, when you are using the view helper.

Second, we've placed an `outlet` tag at the end of the template. Since the lead route is nested under leads, it's content will appear in this outlet. In this case the markup is on the same level in the DOM so this doesn't present a problem. If you had a situation where you needed to output the content elsewhere on the page you could use the [renderTemplate](http://emberjs.com/api/classes/Ember.Route.html#method_renderTemplate) method in the route to specify an outlet somewhere else.

One nice thing about the `link-to` helper is that it automatically adds a class of `active` to the element when you are on the route it's linking to. Our stylesheet takes advantage of this to highlight the currently selected lead.

Now refresh the page and click on a lead. You should see that lead's information show up on the right, and it should be snappy.

Next we'll create form elements and save data.
