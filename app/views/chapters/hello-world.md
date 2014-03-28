# Hello World!

Let’s start with a little bit of code before we go into concepts in-depth. 'Hello World'
is usually a good place to start when learning a new language or framework. This proves
the we have our development environment setup and gives us a rudimentary view of how
things work.

## Create a New Rails App

`rails new ember-hello-world -d postgresql`
cd ember-hello-world

Do what you need to do to get your config/database.yml setup right then
`rake db:create`

## Setup Ember

Remove app/assets/javascripts/application.js.
Remove turbolinks from app/views/layouts/application.html.erb.

Add these to your gemfile:

```ruby
gem 'ember-rails'
gem 'ember-source'
gem 'emblem-rails'
gem 'haml-rails'
```

Run `bundle`

Then run `rails g ember:bootstrap -g --javascript-engine coffee -n App`

Add the following lines to your environment files:

config/environments/test.rb
`config.ember.variant = :development`

config/environments/development.rb
`config.ember.variant = :development`

config/environments/production.rb
`config.ember.variant = :production`

#todo:

remove application.js
:q


## The Ember Code

config/routes.rb
root to: ‘home#index’

app/controllers/home_controller.rb

```ruby
class HomeController < ApplicationController
end
```

app/views/home/index.html.haml

```haml
%script{ type: 'text/x-handlebars' }
  {{ outlet }}
```

app/assets/javascripts/templates/index.js.emblem

```
h1 Hello World
```

Start your server, then visit localhost:3000. You should see ‘Hello World’ printed on the
screen.

Getting this working is the first step in building an Ember app.
