class DashboardController < ApplicationController
    before_action :authenticate_user!

    def show
        @invitations = ToDoListInvite.where(invitee_email: current_user.email, accepted_at: nil).all
    end
end
