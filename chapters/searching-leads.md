# Searching Leads

Let's create a search box that will instantly search leads by name as we type.

The neat thing about this is that it can be accomplished with a surprisingly small amount of code in a very clean manner. That, my friend, is the beauty of Ember.

## Add the Search Field

Add a text field view at the top of the list of leads, right under the `h1`:

```
// app/assets/javascripts/templates/leads.js.emblem
article#leads
  h1
    | Leads
    link-to 'leads.new' | New Lead
  view Ember.TextField value=search placeholder="search" classNames="search"
  ul
  # etc ...
```

I'm binding the text field's value to a property named `search`.

## Change the Loop

Right now we're doing `each lead in controller`. We need to manually modify the list of leads, so change it to `each lead in leads`, and we'll create a `leads` property on the controller.

```
// app/assets/javascripts/templates/leads.js.emblem
ul
  each lead in leads
  # etc ...
```

## Filtering Leads

Open up `LeadsController` and add the following two properties:

```coffee
# app/assets/javascripts/controllers/leads.js.coffee
leads: ( ->
  if @get('search') then @get('searchedLeads') else @
).property('search', 'searchedLeads')

searchedLeads: ( ->
  search = @get('search').toLowerCase()
  @filter (lead) => lead.get('fullName').toLowerCase().indexOf(search) != -1
).property('search', '@each.fullName')
```
```javascript
// app/assets/javascripts/controllers/leads.js
leads: function() {
  return this.get('search') ? this.get('searchedLeads') : this
}.property('search', 'searchedLeads')

searchedLeads: function() {
  var search = this.get('search').toLowerCase()
  return this.filter(function(lead) {
    return lead.get('fullName').toLowerCase().indexOf(search) != -1
  })
}.property('search', 'this.each.fullName')
```

The `leads` property looks to see if there is a search string. If there is, it returns `searchedLeads`. If there isn't, it returns `this`. `this` in an `ArrayController` references the array of models that it is wrapping.

`searchedLeads` gets the search string and lower cases it. It then runs `filter` on `this`, which is the list of leads, and returns the leads where the full name includes the search string.

`searchedLeads` needs to depend on `this.each.fullName', which means that the property will be updated whenever the full name of any lead changes.

## Try It

It should work right now. There are two cool things to notice here.

First, as you search the list of names they stay sorted by first and last name. That's `sortProperties` in action.

Second, try clicking on a lead, then entering a search string that doesn't match. Then, edit the lead's name to something that matches and watch it appear in the search list. That's pretty cool, and it's a good example of how everything is properly bound together.
