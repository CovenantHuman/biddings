class AddUniqueIndexToToDoLists < ActiveRecord::Migration[7.0]
  def change
    add_index :to_do_lists, [:giver_id, :recipient_id], unique: true
  end
end
