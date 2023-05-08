class RemoveColumnsFromToDoListInvites < ActiveRecord::Migration[7.0]
  def change
    remove_column :to_do_list_invites, :to_do_list_id
    remove_column :to_do_list_invites, :name
    remove_column :to_do_list_invites, :giver_id
    remove_column :to_do_list_invites, :recipient_id
  end
end
