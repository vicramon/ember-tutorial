class Contact < ActiveRecord::Base
  validates :email, presence: true
end
