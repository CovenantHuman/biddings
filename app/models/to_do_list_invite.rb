class ToDoListInvite < ApplicationRecord
    belongs_to :to_do_list, optional: true
    belongs_to :inviter, class_name: "User", inverse_of: :to_do_list_invites
    belongs_to :giver, class_name: "User", optional: true
    belongs_to :recipient, class_name: "User", optional: true

    def accepted?
        to_do_list != null
    end

    def send_to_do_list_invitation_email!
        ToDoListInviteMailer.invite(self).deliver_now
    end
end
