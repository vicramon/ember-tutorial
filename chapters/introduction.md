# Introduction

Welcome to my Ember Tutorial!

My intent with this guide is to provide enough instruction on how to use Ember that you could start writing your own app when you're done. I have aimed for my writing to be simple, friendly and concise. I'm very interested in getting feedback and improving this tutorial so please don't hesitate to send me [feedback](mailto:vic@viramon.com) if you have any suggestions.

## What is Ember JS

Ember is a front-end Javascript framework. You can use it to write
complex, front-end heavy web apps. It gives you an organized
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

**Auto-Updating Templates**. Create a property and display it with `{{ myProperty }}` in your Handlebars template. Any updates will appear instantly. Handlebars might not be beautiful, but your templates can look pretty darn good if you use [Emblem](http://emblemjs.com), a templating language for Handlebars that's like Slim.

**Helpful Object APIs**. Ember implements its own set of objects, each of which comes with
a really friendly API. For example Ember has an Array object with methods like `contains`,
`filterBy`, and `sortBy`. These come in handy all the time.

I think Ember is absolutely worth learning if you find yourself needing to build complex front-end applications. Ember may seem like big, but it's really not that complicated. Once you learn how the various Ember objects interact and get a handle on the basics of the API you'll be coding glorious front-end apps in no time.

## Ember is Fun

My takeaway from working in Ember is that it's really *fun*. It opens up new potential for developers to write the crazy front-end apps they've always dreamed of while still maintaining a clean, readable codebase. Also, the Ember core team does a great job of consistently releasing bug fixes and improvements, while keeping the changes non-breaking for a specific version.

At the end of the day, I reckon that if you're going to choose a front-end framework to learn, you can't go wrong if you pick Ember.

## Tutorial Requirements

This tutorial is designed for developers with basic knowledge of Javascript, CoffeeScript, and Ruby
on Rails. You should have a Rails development environment setup on your computer if you want to follow along.

## It's in CoffeeScript

I wrote this tutorial in CoffeeScript because I use CoffeeScript when I write Ember. I think it results in cleaner code, which I care deeply about. If you're going to do full-time development with Ember then I feel like you are better off using CoffeeScript.

I'm not necessarily anti-javascript though, so if you'd like a Javascript version of this tutorial let me know. If I get enough demand for it I'll do it. I considered doing it regardless, but I just wanted to get this thing published.

As a heads up, [JS2Coffee.org](http://js2coffee.org/) can convert any CoffeeScript code to Javascript and vice versa.

## Testing

While I typically use TDD and don't ship code without tests, I'm not covering testing in this tutorial for a couple of reasons.

First, there's a lot to learn here as is, and throwing testing into the mix would make this tutorial just that much more complicated.

Second, you can write integration tests for Ember with Cucumber (or Rspec Integration), and this can be better than using Ember's built in testing helpers because you can test persistence. However, I think you still should write unit tests for your Ember code. I recommend [Ember Qunit](https://github.com/rpflorence/ember-qunit) for that. There's also an [Ember guide on testing](http://emberjs.com/guides/testing/) that I recommend you read after this tutorial.

If there's a lot of demand for help with testing then I can write another section on how to do it, just let me know.

## Questions & Mistakes

If you have a question or find a mistake then please email me at
vic@vicramon.com. The tutorial content is on [GitHub](http://www.github.com/vicramon/ember-tutorial-app) so you can even submit a pull request if you feel so inclined.
