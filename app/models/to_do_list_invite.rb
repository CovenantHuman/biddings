class ToDoListInvite < ApplicationRecord
    :belongs_to :to_do_list
    :belongs_to :inviter, class_name: "User", inverse_of: :to_do_list_invites
    :belongs_to :giver, class_name: "User"
    :belongs_to :recipient, class_name: "User"
end
