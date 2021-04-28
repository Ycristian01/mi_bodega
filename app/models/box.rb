class Box < ApplicationRecord
    has_many :items
    belongs_to :account
end
