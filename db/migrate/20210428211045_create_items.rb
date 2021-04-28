class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.text :description
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
