# Hello World!

Let's build a Hello World app first. We can ensure that we have our development environment setup and get a high level view of how Ember works.

## Create a New Rails App

The app we're going to build in this tutorial is a CRM. We can reuse this hello world code when we start the app, so let's name our Rails app `ember-crm`.

First create new rvm gemset to sandbox our gems:

```shell
rvm gemset create ember-crm
rvm gemset use ember-crm
gem install rails
```

Now generate the Rails app:

```shell
rails new ember-crm -d postgresql
cd ember-crm
bundle
rake db:create
```

If you run `rails s` and visit localhost:3000 then you should see the Rails Welcome Aboard page.

## Remove Turbolinks

You'll need to remove Turbolinks because it conflicts with Ember. Make sure to remove it from all of the following places:

* Gemfile
* Application Javascript (app/assets/javascripts/application.js)
* Layout (app/views/layouts/application.html.erb)

[Commit](https://github.com/vicramon/ember-hello-world/commit/2ec275447edd98e2ec004f4f1c281d4fa4418311)

## Add Ember Rails

I am going to use [Ember Rails](https://github.com/emberjs/ember-rails) for this tutorial. It's stable and works great. I think [Ember Appkit Rails](https://github.com/dockyard/ember-appkit-rails) may eventually replace Ember Rails as the default Rails/Ember integration gem, but it's pre 1.0 right now so I'm going with Ember Rails for this tutorial.

Add following gems to your Gemfile:

```ruby
gem 'ember-rails'
gem 'ember-source'
gem 'emblem-rails'
```

And bundle:

```shell
bundle
```

Ember Rails provides a generator that will create a skeleton for our Ember app. The flags below tell it to use CoffeeScript and to name the Ember app `App`, which is the typical convention.

```shell
rails g ember:bootstrap -g --javascript-engine coffee -n App
```

Ember Rails comes with default Ember versions, but let's explicitly install Ember 1.5.0 and Ember Data 1.0.0 beta 7 so that we know for sure we're using the same versions. They will be installed to `vendor/assets/ember`.

```shell
rails g ember:install --tag=v1.5.0 --ember
rails g ember:install --tag=v1.0.0-beta.7 --ember-data
```

Add the following lines to your environment files. These tell Ember Rails which version of ember.js to use in each environment. The production version is minified and has no logging, while the development version is not minified and allows for logging.

```ruby
# config/environments/test.rb
config.ember.variant = :development

# config/environments/development.rb
config.ember.variant = :development

# config/environments/production.rb
config.ember.variant = :production
```

Ember Rails generates an `application.js.coffee` for us, so lets use that. Delete `application.js`, and make sure to add jQuery to the top of `application.js.coffee`. Ember depends on jQuery.

```coffee
# app/assets/javascripts/application.js.coffee
#= require jquery
#= require jquery_ujs
```

[Commit](https://github.com/vicramon/ember-hello-world/commit/8d34669ae4649ca17d80d5a52dccf98535d36786)

## Making Ember Work

We'll need a basic Rails controller and view so that we can output something from Ember. I'm going to make a controller named `HomeController` with an index view and make it the root path.

Add the route:

```ruby
# config/routes.rb
root to: 'home#index'
```
Create the controller:

```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController
end
```

Create an index view. It's going to be blank:

```html
<!-- app/views/home/index.html.erb -->
```

Last but not least, we need to create a template for Ember to render. Ember looks for an application template by default, so all we need to do is create it:

```haml
// app/assets/javascripts/templates/application.js.emblem
h1 Hello World
```

Restart your server then visit http://localhost:3000. You should see 'Hello World' printed on the screen. If you see it then congratulations! You're one step closer to being an Embereño. Yes, Embereño is a thing, though I kind of like Emberista. 

If you don't see `Hello World`, you should clone my hello world repo and see what you've done differently.

[Commit](https://github.com/vicramon/ember-hello-world/commit/2255b0077f85aeb4d5be6cb8aee041667bc62460)

## Very Basic Debugging

If you open your console you should see output that looks like this:

```
DEBUG: ------------------------------- ember.js?body=1:3522
DEBUG: Ember      : 1.5.0 ember.js?body=1:3522
DEBUG: Handlebars : 1.3.0 ember.js?body=1:3522
DEBUG: jQuery     : 1.11.0 ember.js?body=1:3522
DEBUG: -------------------------------
```

If you don't see this output then your Ember javascripts are not being loaded properly.

There's a whole page on [debugging Ember](http://emberjs.com/guides/understanding-ember/debugging/) in the guides.  I suggest that you check it out if ever get stuck.

The first thing I usually do if things aren't working is place a `debugger` in the code and open Chrome dev tools. If that doesn't help then the next thing I'll do is log my route transitions to get more insight:

```coffee
# app/assets/javascripts/application.js.coffe
window.App = Ember.Application.create(LOG_TRANSITIONS_INTERNAL: true)
```

Beyond that I suggest reading in the guides for more detailed tips on debugging, and of course using the Ember Inspector...

## The Ember Inspector

The Ember Inspector is an invaluable tool for debugging Ember. It's a Chrome Extension that helps you see what's going on in your app. You can get it [here](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi).

Once it's installed refresh your browser and open Chrome dev tools. You should see a tab titled **Ember**. Inside are all sorts of helpful tools. **View Tree** will show you exactly what's being rendered and where it came from. **Routes** show you all the routes in your app, and what other objects each one looks for. The route you are currently on will be bold. **Data** will show you all the active records in your app. You can click on a record to view all of its attributes.

I can't say enough good things about the Ember Inspector. It makes inner the workings of your app very visible.

## Conclusion

As you've seen it doesn't take much time to get our Ember App up and running. Most of the work is in preparing the Rails app.

If you've still got issues getting this working then please post your issue in the comments below. This hello world app is also on [GitHub](https://github.com/vicramon/ember-hello-world) if you want to look at it.
