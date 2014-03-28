# Introduction

## What is Ember JS

Ember is a front-end javascript framework. The benefits of using using a front-end
framework are similar to that of a back-end framework: you get an organized
structure, conventions, and built-in ways to some of the hard things many apps need.

Like Angular, Backbone, and Knockout, Ember arrived on the scene recently to help
developers build great front-end applications while maintaining a clean code base.

## Why Choose Ember

I can’t speak for every other framework out there because I haven’t used them all.
However, I can tell you what’s great about Ember.

**Logical Code Organization**. If you come from a Rails background you will appreciate
Ember’s naming conventions. For example a UsersController looks for a UsersView and a
UsersTemplate.

**Easy Persistence**. Once you have your back-end communicating with Ember, saving a
record as easy as calling `user.save()`. Want to get rid of this user?  Call
`user.destroyRecord()`.

**Auto-Updating Templates**. Ember uses Handlebars templates, which look even better when you use [Emblem](http://emblemjs.com). Create a property then display it with `= myProperty`. Any updates to it will appear instantly.

**Helpful Object API’s** Ember implments it’s own set of objects, each of which comes with
a friendly API. For example, Ember has an Array object with methods like `contains`,
`filterBy`, and `sortBy`.

While there may be a learning curve with Ember, it’s absolutely worth learning if you find
yourself needing to build front-end heavy applications.

## Tutorial Requirements

This tutorial is designed for developers with some basic knowledge of both Javascript and Ruby
on Rails. You should have a Rails development environment setup on your computer.

## Questions & Mistakes

If you have a question or see a mistake in this tutorial then please email me at
vic@vicramon.com.
