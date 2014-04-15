# Editing a Lead Part II

Now we're going to do the other half of editing. A user clicks an edit link and then sees fields to edit the lead's name, phone, and email.

Add a link to our new edit route next inside the `h1` tag:

```coffee
h1
  fullName
  link-to 'edit' 'lead.edit' model classNames='edit'
```
