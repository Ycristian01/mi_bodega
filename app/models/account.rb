class Account < ApplicationRecord
  belongs_to :user

  PASSWORD_REQUIREMENTS = /\A
    (?=.{6,})
    (?=.*\d)
    (?=.*[a-z])
  /x

  validates :name, presence: true
  validates :name, format: { with:  /\A[A-Za-z0-9\-\s]*\z/ }
  validates :subdomain, presence: true
  validates :subdomain, format: { with:  /\A[A-Za-z]*\z/ }
  validates :password, format: PASSWORD_REQUIREMENTS
  validates :cc_number, presence: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  has_many :boxes
  has_many :memberships
  has_many :invites
end
