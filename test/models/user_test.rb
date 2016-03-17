require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example", email: "user@example.com", password:"123456", admin:false)
  end

  test "should be valid" do
    assert @user.valid?
  end

  #Testar så att namn måste finnas
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
  #Testar namnlängd
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  #Testar så att email måste finnas
  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  #Testar email längden
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  # Testar så om email fel format
  test "email wrong format" do
    @user.email = "nah.com"
    assert_not @user.valid?
  end

  # Testar så att email är rätt format
  test "email right format" do
    @user.email = "validasdasdasdasd@gmail.com"
    assert @user.valid?
  end

  #Testar så att password måste finnas
  test "password should be present" do
    @user.password = "   "
    assert_not @user.valid?
  end

  # Testar att minimumlängden för password fungerar
  test "minimumpassword" do
    @user.password = "123"
    assert_not @user.valid?
  end
end
