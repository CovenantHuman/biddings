class CreateToDoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :to_do_lists do |t|
      t.string(:name)
      t.belongs_to(:giver, :foreign_key => {:to_table => :users}, :null => false)
      t.belongs_to(:recipient, :foreign_key => {:to_table => :users}, :null => false)
      t.boolean(:active)

      t.timestamps
    end
  end
end