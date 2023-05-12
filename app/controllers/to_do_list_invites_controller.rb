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

    def accept
        @invitation = ToDoListInvite.find(params[:to_do_list_invite_id])
        unless @invitation.accepted?
            if @invitation.accept
                redirect_to dashboard_path, notice: "Invitation accepted!"
            else
                redirect_to dashboard_path, notice: "Something went wrong while trying to accept that invitation."
            end
        else
            redirect_to dashboard_path, notice: "Invitation already accepted"
        end
    end

    private

    def to_do_list_invite_params
        to_do_list_invite_params = {}
        to_do_list_invite_params[:invitee_email] = params[:to_do_list_invite][:invitee_email]
        to_do_list_invite_params[:inviter_id] = current_user.id
        return to_do_list_invite_params
    end
end
