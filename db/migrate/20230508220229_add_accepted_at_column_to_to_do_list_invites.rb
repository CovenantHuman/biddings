class AddAcceptedAtColumnToToDoListInvites < ActiveRecord::Migration[7.0]
  def change
    add_column :to_do_list_invites, :accepted_at, :datetime
  end
end
