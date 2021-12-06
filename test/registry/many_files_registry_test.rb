require 'test_helper'
require 'registry/registry'
require 'support/assertions'

class ManyFilesRegistryTest < Minitest::Test
  include EachMethodTest

  def setup
    @registry = DuplicateFilesRegistry.new
    @data_path1 = 'data/22.jpg'
    @digest1 = 'c815eaafda365cf8b805fed05d6ccb04bddca917'
    @registry.add_file(@digest1, @data_path1)
    @data_path2 = 'data/23.jpg'
    @digest2 = 'a666eaafda627cf8b805fed05d6ccb04bddca920'
    @registry.add_file(@digest2, @data_path2)
  end

  def test_digests_returns_correct_array
    assert_empty([@digest1, @digest2] - @registry.digests)
  end

  def test_grouped_files_returns_correct_array
    assert_empty([[@data_path1], [@data_path2]] - @registry.grouped_files)
  end

  def test_registry_is_not_empty
    refute @registry.empty?
  end

  def test_uniq_files_count_returns_correct_value
    assert_equal(2, @registry.uniq_files_count)
  end

  def test_registry_group_by_returns_correct_array
    assert_equal([@data_path1],  @registry.group_by(@digest1))
  end

  def test_add_file_to_registry_when_unduplicate_file_added
    data_path3 = 'data/24.jpg'
    digest = 'qwer69afda365cf8b805fed05d6ccb04bddca555'
    @registry.add_file(digest, data_path3)

    assert_equal([[@data_path1], [@data_path2], [data_path3]], @registry.grouped_files)
    assert_equal([@digest1, @digest2, digest], @registry.digests)
    assert_equal(3, @registry.uniq_files_count)
  end

  def test_add_file_to_registry_when_duplicate_file_added
    data_path3 = 'data/24.jpg'
    digest = 'c815eaafda365cf8b805fed05d6ccb04bddca917'
    @registry.add_file(digest, data_path3)

    assert_equal([[@data_path1, data_path3], [@data_path2]], @registry.grouped_files)
    assert_equal([digest, @digest2], @registry.digests)
    assert_equal(2, @registry.uniq_files_count)
  end

  def test_registry_each_returns_correct_value
    assert_block_calls(2) do |counter_block|
      @registry.each(&counter_block)
    end
  end
end
