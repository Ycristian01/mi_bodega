class Account < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :name, format: { with:  /\A[A-Za-z0-9\-\s]*\z/ }
  validates :subdomain, presence: true
  validates :subdomain, format: { with:  /\A[A-Za-z]*\z/ }
  validates :plan, presence: true

  has_many :boxes, dependent: :destroy
  has_many :memberships, dependent: :destroy
end
