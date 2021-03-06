class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.integer :capacity, null: false
      t.boolean :on_duty, null: false, default: false

      t.timestamps null: false
    end
    add_index :responders, :name, unique: true
  end
end
