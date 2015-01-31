# Introduction

Welcome to my Ember Tutorial!

My intent with this guide is to provide enough instruction on how to use Ember that you could start writing your own app when you're done. I have aimed for my writing to be simple, friendly and concise. I'm very interested in getting feedback and improving this tutorial so please don't hesitate to send me [feedback](mailto:vic@vicramon.com) if you have any suggestions.

## Important Notes on Ember CLI

This tutorial was written primarily in May/June of 2014. A lot has changed in Ember-land since then. The biggest change is that [Ember CLI](https://github.com/ember-cli/ember-cli) is now considered the "proper" platform for building your Ember app. Ember CLI has its own learning curve, but it is considered the way forward.

The Ember team is still committed to providing a standalone ember.js distribution that you can use without Ember CLI. So all you really need to run ember is ember.js, jquery, handlebars, and your own ember javascripts. You can throw them all together, point Ember to a back-end, and you're up and running. That being said, if you're starting from scratch, you should probably use Ember CLI, which works well with Rails via [Ember-CLI-Rails](https://github.com/rwz/ember-cli-rails).

The concepts and ideas in this tutorial are still valid, but it really should be ported to Ember-CLI. I'm pretty busy with other projects right now, so if you or someone you know would be interested in doing the port, please have them contact me. This tutorial is also on GitHub, so technically anyone can make a pull request.

As far as I know this tutorial is still the most complete tutorial that covers both the concepts and implementation of Ember, so almost everything you learn here will serve you well even if you are using Ember CLI. So if you're down to learn Ember, you can sit back and enjoy the ride.

## What is Ember JS

Ember is a front-end Javascript framework. You can use it to write
complex, front-end heavy web apps. It gives you an organized
structure, conventions, and built-in ways to do some of the hard things.

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

**Auto-Updating Templates**. Create a property and display it with `{{ myProperty }}` in your Handlebars template. Any updates will appear instantly. Handlebars might not be beautiful, but your templates can look pretty darn good if you use [Emblem](http://emblemjs.com), a templating language for Handlebars that's like Slim.

**Helpful Object APIs**. Ember implements its own set of objects, each of which comes with
a really friendly API. For example Ember has an Array object with methods like `contains`,
`filterBy`, and `sortBy`. These come in handy all the time.

I think Ember is absolutely worth learning if you find yourself needing to build complex front-end applications. Ember may seem big, but it's really not that complicated. Once you learn how the various Ember objects interact and get a handle on the basics of the API you'll be coding glorious front-end apps in no time.

## Ember is Fun

My takeaway from working in Ember is that it's really *fun*. It opens up new potential for developers to write the crazy front-end apps they've always dreamed of while still maintaining a clean, readable codebase. Also, the Ember core team does a great job of consistently releasing bug fixes and improvements, while keeping a stable codebase.

At the end of the day, I reckon that if you're going to choose a front-end framework to learn, you can't go wrong if you pick Ember.

## Tutorial Requirements

This tutorial is designed for developers with basic knowledge of Javascript and Ruby on Rails. You should have a Rails development environment setup on your computer if you want to follow along.

## There are both Javascript and CoffeeScript Versions

I originally wrote this tutorial in CoffeeScript because I use CoffeeScript when I write Ember. I think it results in cleaner code. If you're going to do full-time development with Ember then I feel like you are better off with CoffeeScript.

However, I know that there are many people who don't know or like CoffeeScript, so I went ahead and made a Javascript version too. Just use the toggle in the upper right of the page to switch languages.

As a heads up for CoffeeScript learners, [JS2Coffee.org](http://js2coffee.org/) can convert any CoffeeScript code to Javascript and vice versa.

## Testing

While I typically use TDD and don't ship code without tests, I'm not covering testing in this tutorial for a couple of reasons.

First, there's a lot to learn here as is, and throwing testing into the mix would make this tutorial just that much more complicated.

Second, you can write integration tests for Ember with Cucumber (or Rspec Integration), and this can be better than using Ember's built in testing helpers because you can test persistence. However, I think you still should write unit tests for your Ember code. I recommend [Ember Qunit](https://github.com/rpflorence/ember-qunit) for that. There's also an [Ember guide on testing](http://emberjs.com/guides/testing/) that you can read after this tutorial.

If there's a lot of demand for help with testing then I can write another section on how to do it, just let me know.

## Questions & Mistakes

If you have a question or find a mistake then please email me at
vic@vicramon.com or submit a [pull request](http://www.github.com/vicramon/ember-tutorial).
