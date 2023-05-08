class AddColumnToToDoLists < ActiveRecord::Migration[7.0]
  def change
    add_reference :to_do_lists, :to_do_list_invite, foreign_key: true
  end
end
