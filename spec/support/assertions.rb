module EachMethodTest
  def assert_block_calls(times)
    message = "Expected to returns correct value"" #{ times }"
    count = 0
    counter_block = ->(arg) { count += 1 }
    yield(counter_block)
    expect(times).to eql(count)
  end
end
