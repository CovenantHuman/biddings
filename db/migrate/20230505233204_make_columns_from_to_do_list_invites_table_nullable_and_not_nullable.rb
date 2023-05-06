class MakeColumnsFromToDoListInvitesTableNullableAndNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :to_do_list_invites, :invitee_email, false
    change_column_null :to_do_list_invites, :giver_id, true
    change_column_null :to_do_list_invites, :recipient_id, true
  end
end
