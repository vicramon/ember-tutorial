# Deleting a Lead

This may be the shortest chapter. Deleting in Ember is typically handled by an action.

## Add a Delete Link

Open up the `lead` template and add a delete link immediately above the submit button:

```
// app/assets/javascripts/templates/lead.js.emblem
p
  a.delete href='#' click="delete" delete
  input type='submit' value='Save Changes' click="saveChanges"
  # etc ...
```

## Create the Controller Action

Template actions are handled in the controller, so open up the `LeadController` and add the `delete` action:

```coffee
# app/assets/javascripts/controllers/lead.js.coffee
actions:

  delete: ->
    @get('model').destroyRecord().then =>
      @transitionToRoute 'leads'
```

We call `destroyRecord()` on the model, which sends a `DELETE` request to the server. After we delete the record we need to transition back to the `leads` route.

And that's it!

Next I'll cover adding a new lead.
