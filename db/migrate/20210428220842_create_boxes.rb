class CreateBoxes < ActiveRecord::Migration[6.1]
  def change
    create_table :boxes do |t|
      t.string :name

      t.timestamps
    end
  end
end
