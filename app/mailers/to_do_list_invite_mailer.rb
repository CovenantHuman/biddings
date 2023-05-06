class ToDoListInviteMailer < ApplicationMailer
    default from: User::MAILER_FROM_EMAIL

    def invitation(to_do_list_invite)
        @to_do_list_invite = to_do_list_invite

        mail to: @to_do_list_invite.invitee_email, subject: "You've been invited to participate in a to do list!"
    end
end
