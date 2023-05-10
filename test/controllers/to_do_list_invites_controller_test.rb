require "test_helper"

class ToDoListInvitesControllerTest < ActionDispatch::IntegrationTest
  test "new action should bounce a non logged in user to the homepage" do
    get "/to_do_list_invites/new"
    assert_redirected_to login_path
  end
end
