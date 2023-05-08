class ToDoListInvite < ApplicationRecord
    belongs_to :to_do_list, optional: true
    belongs_to :inviter, class_name: "User", inverse_of: :to_do_list_invites
    belongs_to :giver, class_name: "User", optional: true
    belongs_to :recipient, class_name: "User", optional: true

    before_save :downcase_invitee_email

    def accepted?
        to_do_list != null
    end

    def send_to_do_list_invitation_email!
        ToDoListInviteMailer.invitation(self).deliver_now
    end

    private

    def downcase_invitee_email
        self.invitee_email = invitee_email&.downcase.strip
    end
end
