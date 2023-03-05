class CreateToDoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :to_do_items do |t|
      t.belongs_to :to_do_list, foreign_key: true, null: false
      t.boolean :completed
      t.string :name

      t.timestamps
    end
  end
end
