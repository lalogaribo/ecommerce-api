require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user with valid first, last name and email should be valid" do
    user = User.new(email: 'test123@test.org', password: 'test123', first_name: 'Eduardo', last_name: 'Mendoza')
    assert user.valid?
  end

  test "user should not be valid with missing data" do
    user = User.new(email: 'test@test.org', password: 'test123', last_name: 'Mendoza')
    assert_not user.valid?
  end

  test "user should not be valid with invalid email " do
    user = User.new(email: 'teststorg', password: 'test123', first_name: 'Eduardo', last_name: 'Mendoza')
    assert_not user.valid?
  end

  test "user should not be valid with used email " do
    other_user = users(:one)
    user = User.new(email: other_user.email, password: 'test123', first_name: 'Eduardo', last_name: 'Mendoza')
    assert_not user.valid?
  end
end
