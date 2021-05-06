class Item < ApplicationRecord

  validates :description, presence: true
  belongs_to :box
  has_one_attached :image
end
