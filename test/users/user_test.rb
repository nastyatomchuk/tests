require 'test_helper'
require 'users/user'

class UserTest < Minitest::Test
  def test_full_name_returns_default_value_when_no_name_provided
    user =  User.new

    assert_equal('Ivan Petroff', user.full_name)
  end

  def test_full_name_returns_correct_value_when_all_names_provided
    user = User.new('Petr', 'Ivanov')

    assert_equal('Petr Ivanov', user.full_name)
  end

  def test_full_name_returns_correct_value_when_only_first_name_provided
    user = User.new('Petr')

    assert_equal('Petr Petroff', user.full_name)
  end

  def test_full_name_returns_correct_value_when_empty_last_name_provided
    user = User.new('Ivan', '')

    assert_equal('Ivan', user.full_name)
  end

  def test_full_name_returns_correct_value_when_nil_last_name_provided
    user = User.new('Ivan', nil)

    assert_equal('Ivan', user.full_name)
  end

  def test_full_name_raises_argument_error_when_empty_names_provided
    assert_raises(ArgumentError) { User.new('', '') }
  end

  def test_full_name_raises_argument_error_when_nil_names_provided
    assert_raises(ArgumentError) { User.new(nil, nil) }
  end

  def test_full_name_raises_argument_error_when_empty_first_name_provided
    assert_raises(ArgumentError) { User.new('', 'Petrov') }
  end

  def test_full_name_raises_argument_error_when_nil_first_name_provided
    assert_raises(ArgumentError) { User.new(nil, 'Petrov') }
  end
end
