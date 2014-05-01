# Modeling Leads

To handle data we'll be using [Ember Data](https://github.com/emberjs/data). We already installed it in Hello World so we don't have do anything to start using it. Although there are a few different data adapters for Ember, Ember Data is the standard.

We have a Lead model in Rails but Ember needs to know about leads too. To do that we'll create a lead model in Ember. Ember Data gives us the `DS.Model` object which we'll extend:

```coffee
# app/assets/javascripts/models/lead.js.coffee
App.Lead = DS.Model.extend
  firstName: DS.attr('string')
  lastName: DS.attr('string')
  email: DS.attr('string')
  phone: DS.attr('string')
  status: DS.attr('string', defaultValue: 'new')
  notes: DS.attr('string')
```

Ember will automatically read in the json api's `first_name` to `firstName`, and etc. across the rest of our attributes. We're only using the `string` data type here. The other ones available to you are `number`, `boolean`, and `date`.

## An Aside about DS.Model

[DS.Model](http://emberjs.com/api/data/classes/DS.Model.html) gives you a variety of useful methods and properties. Here are a few methods that you will use often:

```coffee
model.save() # save changes to the database
model.rollback() # wipe clean any unsaved changes
model.destroyRecord() # delete a record from the database
```

Note that DS.Model extends Ember.Object, so all of the things you learned about Ember Objects will still work with DS.Model. For example, you can set an arbitrary property on a DS.Model instance like so:

```coffee
model.set('myProperty', 'hello!')
```

The main difference between DS.Model instances and regular Ember.Object instances is that you cannot create them the same way. To create a new DS.Model instance you have to go through the `store`:

```coffee
@store.createRecord('modelName', firstName: 'John', lastName: 'Snow')
```

This is because the `store` encapsulates your app's knowledge of all the active DS.Model instances, and the store has to do additional work when you create a model instance.
