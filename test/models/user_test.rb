require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user is accepted" do
    user = User.new(email: "ivan@example.com", password: "password123", password_confirmation: "password123")
    assert user.valid?
  end

  test "email required" do
    user = User.new(password: "password123", password_confirmation: "password123")
    refute user.valid?
    assert user.errors[:email].any?
  end

  test "email is normalized" do
    user = User.create!(email: "  IVAN@EXAMPLE.COM  ", password: "password123", password_confirmation: "password123")

    assert_equal "ivan@example.com", user.email
  end
end
