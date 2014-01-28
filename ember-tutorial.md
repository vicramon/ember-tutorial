# Introduction

Welcome to Vic Ramon’s Ember Tutorial. This tutorial provides an introduction to the Ember
JS framework by building an Ember app with a Ruby on Rails backend.

# Table of Contents

Chatper 1: Intro to Ember
Chapter 2: Ember Routing
  - router
  - route, controller, view, template
Chapter 3: Hello World
Chapter 4: Planning the Application
Chapter 5: Modeling Data
Chapter 6: Sign In
  - best way to do this?
Chapter 7: Listing
Chapter 8: Creating New
  - validations
Chapter 9: Editing
Chapter 10: Deleting



## What is Ember JS

Ember is a front-end javascript framework. The benefits of using using a front-end
framework are similar to that of using a back-end framework: you get an organized
structure, conventions, and built-in ways to do the things most apps need.

Like Angular, Backbone, Knockout, and others, Ember arrived on the scene recently to help
developers build great front-end applications while maintaining a clean code base.

## Why Choose Ember

I can’t speak for every other framework out there because I haven’t used them all.
However, I can tell you what’s great about Ember.

**Logical Code Organization**.  If you come from a Rails background, you will appreciate
Ember’s naming conventions. For example a Users Controller looks for a Users View and a
Users Template.

**Easy Persistence**. Once you have your back-end communicating with Ember, saving a
record as easy as calling `user.save()`. Want to get rid of this user?  Call
`user.destroyRecord()`.

**Auto-Updating Templates**. Ember uses Handlebars templates, which look even better with
Emblem. Create a property then display it with `= myProperty`, then any updates to it will
appear instantly.

**Helpful Object API’s** Ember implments it’s own set of objects, each of which comes with
a friendly API. For example, Ember has an Array object with methods like `contains`,
`filterBy`, and `sortBy`.

While there may be a learning curve with Ember, it’s absolutely worth learning if you find
yourself needing to build front-end heavy applications.

## Tutorial Requirements

This tutorial is designed for developers with some knowledge of both Javascript and Ruby
on Rails. You should have a Rails development environment setup on your computer.

## Questions & Mistakes

If you have a question or see a mistake in this tutorial, please email me at
vic@vicramon.com and I will reply to you promptly.

------------------------------------------------------------------------------

# Hello World!

Let’s start with a little bit of code before we go into concepts in-depth. “Hello World”
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

```
gem ‘ember-rails’
gem ‘ember-source’
gem ‘emblem-rails’
gem ‘haml-rails’
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
```
class HomeController < ApplicationController
end
```

app/views/home/index.html.haml
```
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

-----------------------------------------------------------------------------------------

# Ember Concepts

Ember has it’s own set of concepts and constructs that you will need to understand before
jumping into an app. I’m going to go over each of those now.

## Everything Starts in the Router

When you visit a url in your app the first thing Ember does is look in the router to
determine what to do. Let’s look at the router:

``` App.Router.map ()-> @resource ‘posts’ ```

Resource specifies #todo
