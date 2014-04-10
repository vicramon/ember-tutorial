# Creating the Layout

Our project needs to look nice, so I've built an alright-looking UI for it. All you need to do is follow along with the same markupand your project will turn out looking exactly the same.

We need to put some of this UI into action, specifically the header and footer, so we can build stuff inside it. Let's do that now.

## Rails Layout

You shouldn't have to change your Rails layout, but for reference here's what mine looks like in Haml:

```haml
!!!
%html(lang="en-US")
  %head
    %title Ember CRM
    = stylesheet_link_tag "application"
    = javascript_include_tag "application"
    = csrf_meta_tags

  %body
    = yield

  %footer
```

I'm not doing anyting special here as you can see.
