This was at the bottom of editing a lead part 1 but I took it out because I think it's too complicated and may discourage readers.

## Alerting for Fun and Profit

What if you wanted to prompt the user to save changes before switching to a different lead? Here's how you'd do it. I'm not actually keeping this code in my app because I don't like the interaction, but I think it's an interesting exercise that you might want to know how to do.

```coffee
# app/assets/javascripts/routes/lead.js.coffee
contextDidChange: ->
  if lead = @controllerFor('lead').get('model')
    if lead.get('isDirty') and confirm "Do you want to save your changes?"
      lead.save()
    else
      lead.rollback()
```

This is a bit complicated, but here we go:

We're using the `contextDidChange` hook, which is called when the model for the current route changes. We need to get the model we were just editing, but by the time you hit this hook the model for the route has already changed, so we can't get the model with `@modelFor('lead')`. Instead we'll do `@controllerFor('lead').get('model')`, because the controller's model hasn't actually been updated yet (`contextDidChange` is called before `setupController`).

`contextDidChange` is called when you enter the route the first time too, in which case `@controllerFor('lead')` would be empty, so that's why we have the first if statement. If we find a lead model on the controller, we can then ask if it's dirty. If it's dirty, we then prompt the user to either save their changes, or rollback the record to it's previous state.

We can put the isDirty check and the confirm into a single if statement because if the record is not dirty then rolling back won't do anything.
