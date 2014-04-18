# Introduction

Welcome to my Ember Tutorial!

My intent with this guide is to provide enough instruction on how to use Ember that you could start writing your own apps when you're done. I have aimed for my writing to be simple, friendly and concicse. I'm very interested in getting feedback and improving this tutorial, so plesae don't hesitate to send me [feedback](mailto:vic@viramon.com) if you have any suggestions.

## What is Ember JS

Ember is a front-end javascript framework. You would use a front-end framework for the same reasons you
would use a back-end framework. It gives you an organized
structure, conventions, and built-in ways to some of the hard things.

Like Angular, Backbone and Knockout, Ember arrived recently to help
developers build great front-end applications while maintaining a clean code base.

## Why Choose Ember

I can’t speak for every framework out there, but I can tell you what’s great about Ember.

**Logical Code Organization**. If you come from a Rails background you will appreciate
Ember’s naming conventions. For example a Users Controller looks for a Users View and a
Users Template.

**Easy Persistence**. Once you have your back-end communicating with Ember, saving a
record as easy as calling `user.save()`. Want to delete this user?  Call
`user.destroyRecord()`.

**Auto-Updating Templates**. Create a property and display it with `{{ myProperty }}` in your Handlebars template. Any updates will appear instantly. Handlebars might not be beautiful, but your templates can look pretty darn good if you use [Emblem](http://emblemjs.com), a templating language for Handlebars that's similar to Slim.

**Helpful Object APIs**. Ember implments its own set of objects, each of which comes with
a really friendly API. For example Ember has an Array object with methods like `contains`,
`filterBy`, and `sortBy`. These things make your life better.

I think Ember is absolutely worth learning if you find yourself needing to build front-end heavy applications. Ember may seem like a lot, but it's really not that complicated. Once you learn how the various Ember objects interact and get a handle on the basics of the API you'll be coding glorious front-end apps in no time.

Ember is really fun to work with. It opens up new potential for developers to write the crazy front-end apps they've always dreamed of while still maintaing a clean, readable codebase. Also, the Ember core team does a great job of not making any breaking changes within a specific version and getting out bug fixes and improvements very rapidly.

At the end of the day, I reckon that if you're going to choose a front-end framework to learn, you can't go wrong if you pick Ember.

## Tutorial Requirements

This tutorial is designed for developers with some basic knowledge of Javascript, CoffeeScript, and Ruby
on Rails. You should have a Rails development environment setup on your computer if you want to follow along.

## Why CoffeeScript

I decided to write this tutorial in Coffeescript because I think it results in cleaner code, which I care deeply about. If you're going to do full-time development with Ember then I feel like you are better off using CoffeeScript.

If you don't know it, don't worry because it's fairly easy to learn. The [Coffeescript website](http://coffeescript.org/) provides very good documentation. Also, [JS2Coffee.org](http://js2coffee.org/) can convert any CoffeeScript code to Javascript, and vice versa, which is great for experimentation.

I am sure that there are people who disagree with me on this, and that's fine.

## Questions & Mistakes

If you have a question or find a mistake then please email me at
vic@vicramon.com. The tutorial content is on [Github](http://www.github.com/vicramon/ember-tutorial-app) so you can also submit a pull request if you feel so inclined.
