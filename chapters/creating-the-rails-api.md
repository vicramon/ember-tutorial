# Creating the Rails API

We need a Rails API for Ember to communicate with to handle persistence.

## The Active Model Adapter

When we used the Ember Rails generate command to setup Ember it added what's called the Active Model Adapter. You'll see this if you open the store file:

```coffee
# app/assets/javascripts/store.js.coffee
App.Store = DS.Store.extend()
App.ApplicationAdapter = DS.ActiveModelAdapter.extend()
```
```javascript
// app/assets/javascripts/store.js
App.Store = DS.Store.extend()
App.ApplicationAdapter = DS.ActiveModelAdapter.extend()
```

If you don't see this code then replace whatever is in your store with this.

The Active Model Adapter enables Ember to communicate with your Rails backend through  [Active Model Serializers](https://github.com/rails-api/active_model_serializers). Normally you would need to include the `active_model_serializers` gem, but Ember Rails already has it a as a dependency.

## Namespace API Requests

We need to tell Ember to prepend all API requests with `api/v1/`, as we'll be versioning our API. Add these two lines to the top of your store file:

```coffee
# app/assets/javascripts/store.js.coffee
DS.RESTAdapter.reopen
  namespace: 'api/v1'
```
```javascript
// app/assets/javascripts/store.js
DS.RESTAdapter.reopen({
  namespace: 'api/v1'
})
```

## Modeling Leads in Rails

First let's create our leads:

```shell
rails g migration create_leads first_name:string last_name:string email:string phone:string status:string notes:text
```

Open up the migration and make sure to add timestamps:

```ruby
class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :status
      t.text :notes

      t.timestamps
    end
  end
end
```

Run the migration:

```shell
rake db:migrate
```

Now create the Rails model:

```ruby
# app/models/lead.rb
class Lead < ActiveRecord::Base
end
```

## The Rails Serializer

Add the serializer. You need to list out all the attributes you want to serialize into JSON and send to Ember:

```ruby
# app/serializers/lead.rb
class LeadSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :status, :notes
end
```

## The API Controller

Now that we have our model and serializer, we can create the API controller.

First we need routes for the API controller. Add them to the top of your Rails router:

```ruby
# config/routes.rb
namespace :api do
  namespace :v1 do
    resources :leads
  end
end
```

Now create the controller. The actions here are fairly standard:

```ruby
# app/controllers/api/v1/leads_controller.rb
class Api::V1::LeadsController < ApplicationController
  respond_to :json

  def index
    respond_with Lead.all
  end

  def show
    respond_with lead
  end

  def create
    respond_with :api, :v1, Lead.create(lead_params)
  end

  def update
    respond_with lead.update(lead_params)
  end

  def destroy
    respond_with lead.destroy
  end

  private

  def lead
    Lead.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :email, :phone, :status, :notes)
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

    20.times do
      Lead.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number,
        status: random_status,
        notes: Faker::Lorem.paragraph(2)
        )
    end

  end
end
```

Run the populate task:

```shell
rake db:populate
```

Restart the server, and now you should be able to visit [http://localhost:3000/api/v1/leads.json](http://localhost:3000/api/v1/leads.json) and see the JSON output for all leads. [http://localhost:3000/api/v1/leads/1.json](http://localhost:3000/api/v1/leads/1.json) should show you the first lead.

## Puma

While we're fiddling with Rails let's switch out Webrick for [Puma](http://puma.io/). It's much faster and it's multithreaded. All you have to do is add Puma to your Gemfile:

```ruby
# Gemfile
gem 'puma'
```

Bundle and restart your server.

That's it for the Rails side! Now we can get to the fun stuff.
