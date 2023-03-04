class CreateToDoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :to_do_lists do |t|
      t.string :name
      t.references :giver, null: false
      t.references :recipient, null: false
      t.boolean :active

      t.timestamps
    end
    add_foreign_key :to_do_lists, :users, column: :giver_id
    add_foreign_key :to_do_lists, :users, column: :recipient_id
  end
end
