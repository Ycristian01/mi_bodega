class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :accounts, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'

  # before_validation :set_account
  
  # def set_account
  #   self.build_account
  # end
end
