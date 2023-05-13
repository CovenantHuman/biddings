require "test_helper"

class ToDoListControllerTest < ActionDispatch::IntegrationTest
  test "logged in user can go to a to do list they are the giver on" do
    sign_in_as users(:user_with_list_one)
    to_do_list = ToDoList.find_by(giver_id: users(:user_with_list_one))
    get to_do_list_path(id: to_do_list.id)
  end

  test "users can only see to do lists associated with them" do
    sign_in_as users(:user_with_list_one)
    to_do_list = ToDoList.find_by(name: "list_three")
    get to_do_list_path(id: to_do_list.id)
    assert_response 404
  end

  test "if a to do list doesn't exist trying to go to it renders a 404" do
    sign_in_as users(:user_one)
    get to_do_list_path(id: 0)
    assert_response 404
  end
end
