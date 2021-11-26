require 'bundler/setup'
require 'minitest/autorun'
require_relative '../../lib/users/user'

class UserTest < Minitest::Test

  def test_positive_full_name_initialize
     assert_equal('Ivan Petroff', User.new.full_name)
  end

  def test_positive_full_name
    assert_equal('Ivan Ivanov', User.new('Ivan', 'Ivanov').full_name)
  end

  def test_positive_full_name_string
    assert_instance_of(String, User.new('Ivan', 'Ivanov').full_name)
  end

  def test_default_first_name
    user = User.new()
    assert_equal("Ivan", user.first_name)
  end

  def test_default_last_name
    user = User.new()
    assert_equal("Petroff", user.last_name)
  end

  def test_first_name
    user = User.new('Petya', 'Petroff')
    assert_equal("Petya", user.first_name)
  end

  def test_last_name
    user = User.new('Petya', 'Petroff')
    assert_equal("Petroff", user.last_name)
  end

  def test_length_full_name
    assert_equal(10, User.new('Ivan', 'Ivanov').full_name.length - 1)
  end
end
