class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :memberships, dependent: :destroy
  has_many :accounts, through :members, dependent: :destroy
  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'

  accepts_nested_attributes_for :accounts
  # validates_associated :accounts
  #after_initialize :add_account
  
  # Create new blank contact on new record initialize.
  # This makes it so a blank Contact is attached when when
  # we create a new User
  # def add_account
  #   self.accounts ||= Account.new if self.new_record?
  # end
end
