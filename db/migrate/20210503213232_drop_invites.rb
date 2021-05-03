class DropInvites < ActiveRecord::Migration[6.1]
  def up
    drop_table :invites
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
