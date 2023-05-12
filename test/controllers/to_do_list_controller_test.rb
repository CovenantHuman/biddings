require "test_helper"

class ToDoListControllerTest < ActionDispatch::IntegrationTest
  test "logged in user can go to a to do list they are the giver on" do
    sign_in_as users(:user_with_list_one)
    to_do_list = ToDoList.find_by(giver_id: users(:user_with_list_one))
    get to_do_list_path(id: to_do_list.id)
  end
end
