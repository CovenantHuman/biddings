class DashboardController < ApplicationController
    before_action :authenticate_user!

    def show
        @invitations = ToDoListInvite.where(invitee_email: current_user.email, accepted_at: nil).all
        @to_do_lists_given = ToDoList.where(giver_id: current_user.id).all
        @to_do_lists_received = ToDoList.where(recipient_id: current_user.id).all
    end
end
