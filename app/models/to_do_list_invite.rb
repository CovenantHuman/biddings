class ToDoListInvite < ApplicationRecord
    belongs_to :to_do_list, optional: true
    belongs_to :inviter, class_name: "User", inverse_of: :to_do_list_invites
    belongs_to :giver, class_name: "User", optional: true
    belongs_to :recipient, class_name: "User", optional: true

    before_save :downcase_invitee_email

    def accepted?
        accepted_at != nil
    end

    def accept
        @invitee = User.find_by(email: self.invitee_email)
        @inviter = User.find(self.inviter_id)
        @to_do_list_given_by_invitee = ToDoList.new(giver_id: @invitee.id,
                                                    recipient_id: self.inviter_id,
                                                    to_do_list_invite_id: self.id)
        @to_do_list_given_by_inviter = ToDoList.new(giver_id: self.inviter_id,
                                                    recipient_id: @invitee.id,
                                                    to_do_list_invite_id: self.id)
        if @to_do_list_given_by_invitee.save && @to_do_list_given_by_inviter.save
            self.accepted_at = DateTime.now
            self.save
        end
    end

    def send_to_do_list_invitation_email!
        ToDoListInviteMailer.invitation(self).deliver_now
    end

    private

    def downcase_invitee_email
        self.invitee_email = invitee_email&.downcase.strip
    end
end
