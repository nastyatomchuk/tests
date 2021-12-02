require 'test_helper'
require 'registry/registry'

class OneFileRegistryTest < Minitest::Test

  def setup
    @registry = DuplicateFilesRegistry.new
    @data_path = 'data/22.jpg'
    @digest = 'c815eaafda365cf8b805fed05d6ccb04bddca917'
    @registry.add_file(@digest, @data_path)
  end

  def test_digests_returns_correct_array
    assert_equal([@digest], @registry.digests)
  end

  def test_grouped_files_returns_correct_array
    assert_equal([[@data_path]], @registry.grouped_files)
  end

  def test_registry_is_not_empty
    refute @registry.empty?
  end

  def test_uniq_files_count_returns_count_of_uniq_files
    assert_equal(1, @registry.uniq_files_count)
  end
  
  def test_registry_group_by_returns_correcct_array
    assert_equal([@data_path],  @registry.group_by(@digest))
  end

  def test_add_file_to_registry_with_one_file
    assert_equal([[@data_path]], @registry.grouped_files)

    data_path2 = 'data/23.jpg'
    digest = 'abc12eaafda365cf8b805fed05d6ccb04bddca917'
    @registry.add_file(digest, data_path2)

    assert_equal([[@data_path], [data_path2]], @registry.grouped_files)
  end

  def test_registry_each_returns_correct_value
    assert_block_calls(1) do |counter_block|
      @registry.each(&counter_block)
    end
  end

  def assert_block_calls(times)
    count = 0
    counter_block = ->(arg) { count += 1 }
    yield(counter_block)
    assert_equal(times, count)
  end
end
