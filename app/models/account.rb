class Account < ApplicationRecord
  belongs_to :user
  has_many :boxes
  has_many :memberships
end
