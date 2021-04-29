class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accounts
  belongs_to :account
  has_many :memberships

  before_validation :set_account
  
  def set_account
    self.build_account
  end
end
