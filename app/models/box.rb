class Box < ApplicationRecord
    has_many :items
    belongs_to :account
    acts_as_tenant :account
end