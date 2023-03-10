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

  test "all fields other than name are not nullable in the database" do 
    to_do_list = ToDoList.new
    assert_raises(ActiveRecord::NotNullViolation) do 
      to_do_list.save(validate: false)
    end
    to_do_list = ToDoList.new(giver: nil, recipient: users(:user_two), active: true)
    assert_raises(ActiveRecord::NotNullViolation) do
      to_do_list.save(validate: false)
    end
    to_do_list = ToDoList.new(giver: users(:user_one), recipient: nil, active: true)
    assert_raises(ActiveRecord::NotNullViolation) do 
      to_do_list.save(validate: false)
    end
    to_do_list = ToDoList.new(giver: users(:user_one), recipient: users(:user_two), active: nil)
    assert_raises(ActiveRecord::NotNullViolation) do 
      to_do_list.save(validate: false)
    end
    to_do_list = ToDoList.new(giver: users(:user_one), recipient: users(:user_two), active: true)
    assert to_do_list.save
  end
end