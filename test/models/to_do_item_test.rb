require "test_helper"

class ToDoItemTest < ActiveSupport::TestCase
  test "create a to do item" do
    to_do_item = ToDoItem.new(to_do_list: to_do_lists(:list_one), completed: true, name: "laundry")
    assert to_do_item.save
    saved_to_do_item = ToDoItem.find_by(name: "laundry")
    assert saved_to_do_item
    assert saved_to_do_item.completed
    assert_equal "list_one", saved_to_do_item.to_do_list.name
  end
  test "no field should be nullable in the database" do
    to_do_item = ToDoItem.new
    assert_raises(ActiveRecord::NotNullViolation) do 
      to_do_item.save(validate: false)
    end
    to_do_item = ToDoItem.new(to_do_list: nil, completed: true, name: "laundry")
    assert_raises(ActiveRecord::NotNullViolation) do 
      to_do_item.save(validate: false)
    end
    to_do_item = ToDoItem.new(to_do_list: to_do_lists(:list_one), completed: nil, name: "laundry")
    assert_raises(ActiveRecord::NotNullViolation) do 
      to_do_item.save(validate: false)
    end
    to_do_item = ToDoItem.new(to_do_list: to_do_lists(:list_one), completed: true, name: nil)
    assert_raises(ActiveRecord::NotNullViolation) do 
      to_do_item.save(validate: false)
    end
    to_do_item = ToDoItem.new(to_do_list: to_do_lists(:list_one), completed: true, name: "laundry")
    assert to_do_item.save
  end
end
