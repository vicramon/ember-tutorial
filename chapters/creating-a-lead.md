# Creating a Lead

## Add the Route

By now you know the drill...

```coffee
# app/assets/javascripts/router.js.coffee
@resource 'leads', path: '/', ->
  @route 'new'
```
```javascript
// app/assets/javascripts/router.js
this.resource('leads', { path: '/' }, function() {
  this.route('new');
});
```

New lead will be a `route` and not a `resource` because it does not need to load an existing model in our system.

## Setup the Fields

We're going to create a `fields` property that will be a plain javascript object. We'll use this to hold the attributes for the new lead until we're ready to actually create it.

We set `fields` to an empty object in the route so that it's reset every time we visit the new lead route.

```coffee
# app/assets/javascripts/routes/leads_new.js.coffee
App.LeadsNewRoute = Ember.Route.extend

  setupController: (controller) ->
    controller.set 'fields', {}
```
```javascript
// app/assets/javascripts/routes/leads_new.js
App.LeadsNewRoute = Ember.Route.extend({

  setupController: function(controller) {
    controller.set('fields', {})
  }

});
```

## Create the Template

And here's our new lead template. Note that it goes in `templates/leads/` because it's a `route` nested under a resource named `leads`.

```
// app/assets/javascripts/templates/leads/new.js.emblem
article#lead
  h1 New Lead

  form
    fieldset
      dl
        dt: label First Name:
        dd: view Ember.TextField value=fields.firstName

      dl
        dt: label Last Name:
        dd: view Ember.TextField value=fields.lastName

      dl
        dt: label Email:
        dd: view Ember.TextField value=fields.email

      dl
        dt: label Phone:
        dd: view Ember.TextField value=fields.phone

    fieldset.actions
      input type='submit' value='Create Lead' click="createLead"
```

As you can see, I've bound all of the inputs to the `fields` property.

The submit has a click action called `createLead`, which we'll deal with now.

## Handle the Action

Create a controller to handle the `createLead` action:

```coffee
# app/assets/javascripts/controllers/leads_new.js.coffee
App.LeadsNewController = Ember.Controller.extend

  actions:

    createLead: ->
      lead = @store.createRecord 'lead', @get('fields')
      lead.save().then =>
        @transitionToRoute 'lead', lead
```
```javascript
// app/assets/javascripts/controllers/leads_new.js
App.LeadsNewController = Ember.Controller.extend({

  actions: {
    createLead: function() {
      var self = this;
      var lead = this.store.createRecord('lead', this.get('fields'));
      lead.save().then(function() {
        self.transitionToRoute('lead', lead);
      });
    }
  }

});
```

This action first calls `createRecord`, which we pass the string name of the model and an object with the attributes we want to give the new model. Since we bound `fields` to all the attributes we can just use it as is. If you logged `fields` you would see something like `{ firstName: 'Sam', lastName: 'Smith', email: 'sam@example.com', phone: '123-456-7890' }`.

Once the record is created we save it, then transition to the show lead route.

There's another common pattern to create new records that I didn't use. I could have created a new record in the route and bound the inputs to the record. The reason I didn't do this is because I didn't want the record to show up in our list of leads on the left until the user pressed "Create Lead". By keeping the attributes in `fields` and waiting until `createLead` is called to create a record, the record won't appear in the list until the user has chosen to create it.

## Add a Link

Add a link to our new lead route in the `leads` template:

```
// app/assets/javascripts/templates/leads.js.emblem
article#leads
  h1
    | Leads
    link-to 'leads.new' | New Lead
```

Now refresh and try it. Everything should work, but it's not perfect. You can create leads where every attribute is null. We should perform a validation here to prevent this.

## Perform Validations

Validation libraries for Ember exist and if you want to use one I recommend [Dockyard's Ember Validations](https://github.com/dockyard/ember-validations) library. However, given Ember's robust object system and the large amount of control it gives you over the client, you don't necessarily need a library.

I'm going to do these validations by hand. There are any number of different ways to do validations, this is just one.

First let's define a valid method on the Lead class. Let's say we just care that a first and last name are present:

```coffee
# app/assets/javascripts/models/lead.js.coffee
App.Lead.reopenClass

  valid: (fields) ->
    fields.firstName and fields.lastName
```
```javascript
// app/assets/javascripts/models/lead.js
App.Lead.reopenClass({

  valid: function(fields) {
    return fields.firstName && fields.lastName
  }

});
```

We pass this method an object with the attributes we want to assign to a lead, and it tells us if this collection of attributes is valid or not.

Now we need to modify our `createLead` method in the new lead controller:

```coffee
# app/assets/javascripts/controllers/leads_new.js.coffee
createLead: ->
  fields = @get('fields')
  if App.Lead.valid(fields)
    lead = @store.createRecord 'lead', fields
    lead.save().then (lead) =>
      @transitionToRoute 'lead', lead
  else
    @set 'showError', true
```
```javascript
// app/assets/javascripts/controllers/leads_new.js
createLead: function() {

  var self = this;
  var fields = this.get('fields')

  if (App.Lead.valid(fields)) {
    var lead = this.store.createRecord('lead', fields)
    lead.save().then(function(lead) {
      self.transitionToRoute('lead', lead)
    });
  } else {
    this.set('showError', true)
  }
}
```

We check to see if these fields are valid. If they are, create the record. If they aren't, set the `showError` property to true. Now we can use the `showError` property to display a message to the user:

```
// app/assets/javascripts/templates/leads/new.js.coffee
article#lead
  h1 New Lead

  if showError
    .error Leads must have a first and last name.
```

One last thing: controller instances remain active, so if you created this error, went to another route, then came back, the `showError` property would still be true. We don't want that, so we need to default it to false in the route on `setupController`:

```coffee
# app/assets/javascripts/routes/leads_new.js.coffee
setupController: (controller) ->
   # etc...
   controller.set 'showError', false
```
```javascript
// app/assets/javascripts/routes/leads_new.js
setupController: function(controller) {
   // etc...
   controller.set('showError', false)
}
```

Now if you create the error, leave, then come back, the form should be fully reset.

That's it for adding leads. This chapter feels a bit dry, but creating new records is probably something you'll do a lot so it's good to know.

The next chapter is more exciting: we're going to instantly search leads.
