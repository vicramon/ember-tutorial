# Editing a Lead Part II

Now let's finish the second half of editing. In this scenario a user clicks on the "edit" link and sees fields to edit the lead's name, phone, and email.

This UI need will replace the UI that shows the lead, so we'll have to do some special work to handle that.

## Add a Route

As always, add a route first. We will place an `edit` route under our existing `lead` resource. The `lead` resource handles fetching the lead. We shouldn't repeat that work if we don't need to.

```coffee
# app/assets/javascripts/router.js.coffee
@resource 'lead', path: 'leads/:id', ->
  @route 'edit'
```
```javascript
// app/assets/javascripts/router.js
this.resource('lead', { path: 'leads/:id' }, function() {
  this.route('edit')
})
```

<p class="coffeescript">
Make sure to add `, ->` after the lead resource.
</p>

This route is going to look for a `LeadEdit` controller, view, and template.

## Create the Template

I'm going to add the template first because it will inform us about what actions we need to handle in the controller.

Since this `route` is nested inside a `resource`, Ember expects the template to be inside a subdirectory with the name of the resource. So this template will be `app/assets/javascripts/templates/lead/edit.js.emblem`.

If you're not sure where to place a template just look in the Ember Inspector's "Routes" tab.

```
// app/assets/javascripts/templates/lead/edit.js.emblem
article#lead
  h1
    model.fullName

  form
    fieldset
      dl
        dt: label First Name:
        dd: view Ember.TextField value=model.firstName

      dl
        dt: label Last Name:
        dd: view Ember.TextField value=model.lastName

      dl
        dt: label Email:
        dd: view Ember.TextField value=model.email

      dl
        dt: label Phone:
        dd: view Ember.TextField value=model.phone

    fieldset.actions
      input type='submit' value='Save Changes' click="saveChanges"
      a.cancel href="#" click="cancel" cancel
```

You can use a colon `:` in Emblem to nest elements on the same line.

Ember gives you the `Ember.TextField` view which renders a text input. Just assign `value` to the property you want to bind to.

The `form` tag doesn't actually do anything, it's just there for markup.

This template has two actions: `saveChanges` and `cancel`. Let's implement them now.

## Create the Controller

```coffee
# app/assets/javascripts/controllers/lead_edit.js.coffee
App.LeadEditController = Ember.ObjectController.extend
  actions:
    saveChanges: ->
      @get('model').save().then =>
        @transitionToRoute 'lead'

    cancel: ->
      @get('model').rollback()
      @transitionToRoute 'lead'
```
```javascript
// app/assets/javascripts/controllers/lead_edit.js
App.LeadEditController = Ember.ObjectController.extend({
  actions: {
    saveChanges: function() {
      var self = this;
      this.get('model').save().then(function() {
        self.transitionToRoute('lead');
      })
    },

    cancel: function() {
      this.get('model').rollback();
      this.transitionToRoute('lead');
    }
  }
})
```

This part is fairly simple, though you might not be familiar with `.then`. `save()` returns a `Promise` object, which we can call `.then` on to execute code when the promise is resolved. Basically what this means is that `transitionToRoute` won't be called until the server has confirmed that the model was saved.

## Add the Edit Link

We need a way to get to our new route. Add a link inside the `h1` tag in the `lead` template. Don't worry, the stylesheet will make it look pretty.

```emblem
// app/assets/javascripts/templates/lead.js.emblem
h1
  model.fullName
  link-to 'edit' 'lead.edit' model classNames='edit'
```

The first argument, `'edit'`, is the link text. The second, `'lead.edit'`, is the route name.

## Try It

Open the browser and try clicking the edit link. You should see the URL change, but nothing else should happen. Can you figure out why?

**Outlets**, don't forget about them. If a template doesn't appear, always ask yourself: **did I add an outlet?!** If you're like me, you'll forget one at some point and be super annoyed that your template isn't showing up.

Our `edit` route is nested under `lead` so Ember is trying to render the template into an `outlet` tag inside the `lead` template. Since it can't find it, nothing happens.

Add an outlet to the top of the `lead` template:

```
// app/assets/javascripts/templates/lead.js.emblem
outlet
```

Now try it. It should work, but now we have a new problem: the show UI for a lead is still present. That's because **nested routes means nested UI**. Since the `lead` resource is still active, the UI is still active.

There's a simple fix to this -- we'll just hide the show UI when we're editing.

## I Heard You Like Editing

Now we'll set an `isEditing` property on the `lead` controller to hide the UI we don't want to see when it's true.

First add `unless isEditing` to the template and indent all the show UI under it:

```
// app/assets/javascripts/templates/lead.js.emblem
outlet

unless isEditing
  article#lead
    h1
      fullName
      link-to 'edit' 'lead.edit' model classNames='edit'
  // etc...
```

Now whenever we visit the edit route we need to set `isEditing` to true. We can do that inside the `LeadEdit` route. We haven't made one yet, so do it now:

```coffee
# app/assets/javascripts/routes/lead_edit.js.coffee
App.LeadEditRoute = Ember.Route.extend
  activate:   -> @controllerFor('lead').set 'isEditing', true
  deactivate: -> @controllerFor('lead').set 'isEditing', false
```
```javascript
// app/assets/javascripts/routes/lead_edit.js
App.LeadEditRoute = Ember.Route.extend({
  activate:   function() { this.controllerFor('lead').set('isEditing', true) },
  deactivate: function() { this.controllerFor('lead').set('isEditing', false) }
})
```

Now we see those route hooks coming in handy! On `activate` we get the `LeadController` and set `isEditing` to true. On `deactivate` we do the opposite. And boom, we're done.

We could do one last thing for clarity -- add `isEditing` to the `LeadController` and default it to false.

```coffee
# app/assets/javascripts/controllers/lead.js.coffee
App.LeadController = Ember.ObjectController.extend
  isEditing: false
  #etc...
```
```javascript
// app/assets/javascripts/controllers/lead.js
App.LeadController = Ember.ObjectController.extend({
  isEditing: false,
  // etc...
})
```

This way future programmers (or our future selves) will know that we have an `isEditing` property on this controller and it should be `false` by default. We don't have to do this but I think it's good style.

Now that we can edit everything about leads I'll show you how to delete them.
