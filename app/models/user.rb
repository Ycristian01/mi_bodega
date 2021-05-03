class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships, dependent: :destroy
  has_one :account, dependent: :destroy

  accepts_nested_attributes_for :account
  # validates_associated :accounts
  #after_initialize :add_account
  
  # Create new blank contact on new record initialize.
  # This makes it so a blank Contact is attached when when
  # we create a new User
  # def add_account
  #   self.accounts ||= Account.new if self.new_record?
  # end
end
