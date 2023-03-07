require "test_helper"

class ToDoListTest < ActiveSupport::TestCase
  test "create a to do list" do
    to_do_list = ToDoList.new(name: "test", giver: users(:user_one), recipient: users(:user_two), active: true)
    assert to_do_list.save
    saved_to_do_list = ToDoList.find_by(name: "test")
    assert saved_to_do_list
    assert saved_to_do_list.active
    assert_equal "one", saved_to_do_list.giver.name
    assert_equal "two", saved_to_do_list.recipient.name
  end
end
