require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "create a user" do
    user = User.new(email: "user@example.com", name: "user", password_digest: "test")
    assert user.save
    saved_user = User.find_by email: "user@example.com"
    assert saved_user
    assert_equal "user", saved_user.name
  end

  test "destroy a user" do
    user = User.new(email: "user@example.com", name: "user", password_digest: "test")
    user.save
    assert user.destroy
    assert_not User.find_by(email: "user@example.com")
  end

  test "update name and email fields" do
    user = User.new(email: "user@example.com", name: "user", password_digest: "test")
    user.save
    saved_user = User.find_by email: "user@example.com"
    saved_user.email = "updated_user@example.com"
    saved_user.name = "updated_user"
    saved_user.save
    updated_user = User.find_by email: "updated_user@example.com"
    assert_equal "updated_user", updated_user.name
    assert_not User.find_by(email: "user@example.com")
  end

  test "read name and email fields" do
    user = User.new(email: "user@example.com", name: "user", password_digest: "test")
    user.save
    saved_user = User.find_by email: "user@example.com"
    assert_equal "user@example.com", saved_user.email
    assert_equal "user", saved_user.name
  end 

  test "emails are required to be in a certain format" do
    user_with_bad_email = User.new(email: "userexamplecom", name: "user", password_digest: "test")
    assert_not user_with_bad_email.save
  end

  test "password_digests must follow certain paramaters" do
    skip("This functionality is not yet implemented.")
    user_with_bad_password_digest = User.new(email: "user@example.com", name: "user", password_digest: "")
    assert_not user_with_bad_password_digest.save
  end

  test "password_digest can be validated or not appropriately" do
    skip("This functionality is not yet implemented.")
    flunk
  end

  test "email and password_digest should not be null in the database" do
    user = User.new
    assert_raises(ActiveRecord::NotNullViolation) do 
      user.save(validate: false)
    end
    user = User.new(email: "user@example.com", password_digest: nil)
    assert_raises(ActiveRecord::NotNullViolation) do 
      user.save(validate: false)
    end
    user = User.new(email: nil, password_digest: "test")
    assert_raises(ActiveRecord::NotNullViolation) do 
      user.save(validate: false)
    end
    user = User.new(email: "user@example.com", password_digest: "test")
    assert user.save
  end

  test "email and password_digest should not be null on model" do
    user = User.new
    assert_not user.save
    user = User.new(email: "user@example.com", password_digest: nil)
    assert_not user.save
    user = User.new(email: nil, password_digest: "test")
    assert_not user.save
    user = User.new(email: "user@example.com", password_digest: "test")
    assert user.save
  end

  test "emails should be unique" do
    user = User.new(email: "user@example.com", name: "user", password_digest: "test")
    user.save
    second_user = User.new(email: "user@example.com", name: "second_user", password_digest: "test")
    assert_not second_user.save
  end

  test "attempting to read password_digest fails" do
    skip("This functionality is not yet implemented.")
    user = User.new(email: "user@example.com", name: "user", password_digest: "test")
    user.save
    saved_user = User.find_by email: "user@example.com"
    assert_not saved_user.password_digest
  end
 
  test "password_digest can be updated" do
    skip("This functionality is not yet implemented.")
    user = User.new(email: "user@example.com", name: "user", password_digest: "test")
    user.save
    saved_user = User.find_by email: "user@example.com"
    flunk
  end
end
