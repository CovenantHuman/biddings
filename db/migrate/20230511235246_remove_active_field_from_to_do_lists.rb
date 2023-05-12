class RemoveActiveFieldFromToDoLists < ActiveRecord::Migration[7.0]
  def change
    remove_column :to_do_lists, :active
  end
end
