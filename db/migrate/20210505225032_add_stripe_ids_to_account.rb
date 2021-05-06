class AddStripeIdsToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :stripe_id, :string
    add_column :accounts, :stripe_card_id, :string
  end
end
