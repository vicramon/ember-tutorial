# Creating the Rails API

We need an API so that Ember can communicate with our Rails app. This chapters shows you how to make one.

## The Active Model Serializer Adapter

When we used the ember-rails generate command it setup Ember to use what's called the Active Model Serializer Adapter. You'll see this if you open your store.js file:

```coffee
# app/assets/javascripts/store.js
App.Store = DS.Store.extend
  adapter: '_ams'
```

This adapter enables Ember to communicate with your Rails back-end through  [Active Model Serializers](https://github.com/rails-api/active_model_serializers), which come standard with Rails. This all works together very smoothly.

## Modeling Leads in Rails

First let's create our leads:

```shell
rails g migration create_leads first_name:string last_name:string phone:string status:string notes:text
```

Open up the migration and make sure to add timestamps:

```ruby
class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :status
      t.text :notes

      t.timestamps
    end
  end
end
```

```shell
rake db:migrate
```

Now create the model:

```ruby
# app/models/lead.rb
class Lead < ActiveRecord::Base
end
```

## The Rails Serializer

Add the serializer. Note that you need to list out all the attributes you want to serialize into JSON and send to Ember.

```ruby
# app/serializers/lead.rb

class LeadSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone, :status, :notes
end
```

## The API Controller

Add the routes for the API controller:

```ruby
# config/routes.rb

namespace :api do
  namespace :v1 do
    resources :leads
  end
end
```

Now that we have our model and serializer, we can create the API controller.
The actions here are fairly standard so this shouldn't be anything new to you.

```ruby
# app/controllers/api/v1/leads_controller.rb

class Api::V1::LeadsController < ApplicationController
  respond_to :json

  def index
    respond_with Lead.all
  end

  def show
    respond_with Lead.find(params[:id])
  end

  def create
    respond_with :api, :v1, Lead.create(lead_params)
  end

  def update
    respond_with Lead.find(params[:id]).update_attributes(lead_params)
  end

  def destroy
    respond_with Lead.find(params[:id]).destroy
  end

  private

  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :phone, :status, :notes)
  end

end
```

## See it in Action

Let's create some records and see our API actually work. 

First add the faker gem:

```ruby
# Gemfile
gem 'faker'
```

Then create a populate task:

```ruby
# lib/tasks/populate.rake

namespace :db do
  task populate: :environment do

    Lead.destroy_all

    def random_status
      ['new', 'in progress', 'closed', 'bad'].sample
    end

    30.times do
      Lead.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        phone: Faker::PhoneNumber.phone_number,
        status: random_status,
        notes: Faker::Lorem.paragraph(2)
        )
    end

  end
end
```

```shell
rake db:populate
```

Now you should be able to visit [http://localhost:3000/api/v1/leads.json](http://localhost:3000/api/v1/leads.json) and see the JSON output for all 30 leads. [http://localhost:3000/api/v1/leads/1.json](http://localhost:3000/api/v1/leads/1.json) should show you the first lead.

## Puma

While we're fiddling with Rails let's switch out Webrick for [Puma](http://puma.io/). It's much faster and it's multithreaded. All you have to do is add puma to your Gemfile:

```ruby
# Gemfile
gem 'puma'
```

Bundle and restart your server.

That's it for the Rails side! Now we can get to the fun stuff.
