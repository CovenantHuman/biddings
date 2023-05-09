class MakeInviteeEmailAnIndexOnToDoListInvites < ActiveRecord::Migration[7.0]
  def change
    add_index :to_do_list_invites, :invitee_email
  end
end
