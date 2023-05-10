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
end
