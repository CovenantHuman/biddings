require "test_helper"

class ToDoListInvitesControllerTest < ActionDispatch::IntegrationTest
  test "new action should bounce a non logged in user to the homepage" do
    get "/to_do_list_invites/new"
    assert_redirected_to login_path
  end

  test "create an invitation" do
    sign_in_as users(:user_one)
    post to_do_list_invites_path(to_do_list_invite:{invitee_email: users(:user_two).email})
    assert_redirected_to dashboard_path
    assert_equal "Invitation Sent!", flash[:notice]
    invite = ToDoListInvite.find_by(inviter_id: users(:user_one).id)
    assert_equal "two@example.com", invite.invitee_email
    assert_equal 1, ActionMailer::Base.deliveries.count
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["two@example.com"], mail.to
    assert_match "invited", mail.body.encoded
  end

  test "create and accept an invitation" do
    inviter = users(:user_one)
    invitee = users(:user_two)

    sign_in_as inviter
    post to_do_list_invites_path(to_do_list_invite:{invitee_email: invitee.email})
    delete logout_path

    sign_in_as invitee
    invite = ToDoListInvite.find_by(inviter_id: users(:user_one).id) 
    post to_do_list_invite_accept_path(to_do_list_invite_id: invite.id) 
    assert_redirected_to dashboard_path
    assert_equal "Invitation accepted!", flash[:notice]
    assert(ToDoList.find_by(to_do_list_invite_id: invite.id, giver_id: invitee.id, recipient_id: inviter.id))
    assert(ToDoList.find_by(to_do_list_invite_id: invite.id, giver_id: inviter.id, recipient_id: invitee.id))
  end

  test "invitation failure when accepting invitation twice" do
    inviter = users(:user_one)
    invitee = users(:user_two)

    sign_in_as inviter
    post to_do_list_invites_path(to_do_list_invite:{invitee_email: invitee.email})
    delete logout_path

    sign_in_as invitee
    invite = ToDoListInvite.find_by(inviter_id: users(:user_one).id) 
    post to_do_list_invite_accept_path(to_do_list_invite_id: invite.id) 
    post to_do_list_invite_accept_path(to_do_list_invite_id: invite.id)
    assert_redirected_to dashboard_path
    assert_equal "Invitation already accepted", flash[:notice]
  end
end

