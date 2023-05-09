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
        @invitation.accepted_at = DateTime.now
        if @invitation.save
            @invitee = User.find_by(email: @invitation.invitee_email)
            @inviter = User.find(@invitation.inviter_id)
            @to_do_list_given_by_intivee = ToDoList.new(name: "For #{@inviter.name} to do", 
                                                        giver_id: @invitee.id,
                                                        recipient_id: @invitation.inviter_id,
                                                        active: true,
                                                        to_do_list_invite_id: @invitation.id)
            @to_do_list_given_by_inviter = ToDoList.new(name: "To dos from #{@inviter.name}",
                                                         giver_id: @invitation.inviter_id,
                                                         recipient_id: @invitee.id,
                                                         active: true,
                                                         to_do_list_invite_id: @invitation.id)
            @to_do_list_given_by_intivee.save
            @to_do_list_given_by_inviter.save
            redirect_to dashboard_path, notice: "Invitation accepted!"
        else
            redirect_to dashboard_path, status: :unprocessable_entity
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
