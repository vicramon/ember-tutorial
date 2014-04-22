# Editing a Lead Part I

There are two places to edit a lead in the app. We have status and notes which are immediately visible on lead show, and we can also click an "edit" link that will let us edit the lead's basic info like name, email, and phone.

Let's start with the status and notes, which will just be additions to our existing lead route and template.

## Add the Status Select

First we need to tell the app about the different statuses a lead can have. The `Lead` model should know about this, but it's more of class knowledge and instance knowledge, so lets use `reopenClass` to add it to the class.

Add this code after your `Lead` model in the same file:

```coffee
# app/assets/javascripts/models/lead/js.coffee
App.Lead.reopenClass
  STATUSES: ['new', 'in progress', 'closed', 'bad']
```

You will now be able to get to this array through `App.Lead.STATUSES`.

Open the lead template and add the following to the bottom:

```
/* app/assets/javascripts/templates/lead.js.emblem */
p
  label Status:
  '
  view Ember.Select content=App.Lead.STATUSES value=model.status
```

Ember provides a built in select view which we can use. We point `content` to our status array, and we point `value` to our lead's status. Now this select will be automatically bound to the lead model's status.

## Add the Notes

Add this code after the status select:

```
/* app/assets/javascripts/templates/lead.js.emblem */
p
  label Notes:
  br
  view Ember.TextArea value=model.notes
```

Here we use Ember's text area view and bind it to `model.notes`.

## Add a Submit Button

Here's our submit button:

```
/* app/assets/javascripts/templates/lead.js.emblem */
p
  input type='submit' value='Save Changes' click='saveChanges'
```

The `click` attribute specifies a function to call when you click this button. Ember expects the controller to define this function.

## Save the Record

Now everything in our form is wired up except the submit button.

Create a `LeadController` to handle the `saveChanges` click action:

```coffee
# app/assets/javascripts/controllers/lead.js.coffee
App.LeadController = Ember.ObjectController.extend

  actions:
    saveChanges: -> @get('model').save()
```

Note that this controller is an `ObjectController`.

Our submit button will call the `saveChanges` function. This function must be within `actions` since it is being called from the template. This is an Ember convention to help keep your code organized.

`save()` will actually send an ajax put request to our Rails API, and everything should just work. Try it out in your browser. Edit a record, click "Save Changes", and look at the Network tab in the Chrome console. You should see a put request to `api/v1/leads/{ id of record }`. If you refresh the page the saved record should show your changes.

Saving is that easy! Just bind and call `save()`. It's fun and it's healthy.

Ember will always send an API request on save, even if the record isn't dirty. You can prevent this behavior with a simple if:

```coffee
saveChanges: -> @get('model').save() if @get('model.isDirty')
```

## Show Helpful Feedback

Now we're going to get fancy and give the user some nice feedback around saving. When there are unsaved changes, we'll show **unsaved changes**, and when the record is actually saving we'll show **saving...**.

First add these to the template after the submit button:

```
p
  input type='submit' value='Save Changes' click="saveChanges"
  if isDirty
    .unsaved unsaved changes
  if isSaving
    .saving saving...
```

Ember will look in the controller to find `isDirty` and `isSaving`. If the controller doesn't find them it will look in the model. Both `isSaving` and `isDirty` come built-in with `DS.Model`, so we are actually done.

Try it out it in the browser. You should see **unsaved changes** appear in red next to the save button if you add anything to notes or change the status of a lead. Click "save changes" to see **saving...** in green. It will probably appear only briefly -- since you are in development the server is going to be quick.


## Prettifying "Saving..."

We have a little problem here. **unsaved changes** is still visible while you are saving a record. You can see this more easily if you add `sleep 1` to the top of your `update` action in the leads API controller. This is because the record remains dirty until saving is completed, as you would expect. Let's do some work to hide this text while saving.

We'll make a property called `showUnsavedMessage`. Replace `isDirty` with `showUnsavedMessage` in the template:

```
if showUnsavedMessage
  .unsaved unsaved changes
```

Open the controller and add the property:

```coffee
# app/assets/javascripts/controllers/lead.js.coffee
App.LeadController = Ember.ObjectController.extend

  showUnsaved: ( ->
    @get('isDirty') and !@get('isSaving')
  ).property('isDirty', 'isSaving')
```

Now, because programming, the message will disappear when the record is saving.

That's it for editing part one. Upwards and onwards!
