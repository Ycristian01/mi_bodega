class AddCurrentTenantIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :current_tenant_id, :integer
  end
end
