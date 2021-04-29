class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|
      t.string :email
      t.integer :sender_id
      t.integer :recipient_id
      t.references :account, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
