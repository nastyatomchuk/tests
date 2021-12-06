require "minitest/assertions"

module EachMethodTest
  def assert_block_calls(times)
    message = "Expected to returns correct value"" #{ times }"
    count = 0
    counter_block = ->(arg) { count += 1 }
    yield(counter_block)
    assert_equal times, count, message
  end
end
