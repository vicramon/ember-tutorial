# Creating the Rails API

## The Active Model Serializer Adapter

When we used the EmberRails generate command it setup Ember to use what's called the Active Model Serializer Adapter. You'll see this if you open your store.js file:

```coffee
# app/assets/javascripts/store.js
App.Store = DS.Store.extend
  adapter: '_ams'
```

This adapter enables Ember to communicate with your back-end through through [Active Model Serializers](https://github.com/rails-api/active_model_serializers).

## Modeling Leads in Rails

Let's create our leads:

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

Add the serializer:

```ruby
# app/serializers/lead.rb

class LeadSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone, :status, :notes
end
```

Now add the routes for the API controller:

```ruby
# config/routes.rb

namespace :api do
  namespace :v1 do
    resource :leads
  end
end
```
