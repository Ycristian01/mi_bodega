class Box < ApplicationRecord
  has_many :items
  acts_as_tenant :account

  validates :name, presence: true
  validates :name, format: { with:  /\A[A-Za-z0-9\-\s]*\z/ }
end