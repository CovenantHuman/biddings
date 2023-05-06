class ToDoListInvitesController < ApplicationController
    before_action :authenticate_user!

    def create
        @to_do_list_invite = ToDoListInvite.new(to_do_list_invite_params)
        if @to_do_list_invite.save
            @to_do_list_invite.send_to_do_list_invitation_email!
            redirect_to dashboard_path, notice: "Invitation Sent!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def new
        @to_do_list_invite = ToDoListInvite.new
    end

    private

    def to_do_list_invite_params
    end
end
