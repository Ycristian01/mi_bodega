class Account < ApplicationRecord
  belongs_to :user
  
  has_many :users
  has_many :boxes
  has_many :memberships
  has_many :invites
end
