class CreateToDoListInviteTable < ActiveRecord::Migration[7.0]
  def change
    create_table :to_do_list_invites do |t|
      t.belongs_to(:to_do_list, :foreign_key => {:to_table => :to_do_lists})
      t.belongs_to(:inviter, :foreign_key => {:to_table => :users}, :null => false)
      t.string :invitee_email
      t.string :name
      t.belongs_to(:giver, :foreign_key => {:to_table => :users}, :null => false)
      t.belongs_to(:recipient, :foreign_key => {:to_table => :users}, :null => false)

      t.timestamps
    end
  end
end
