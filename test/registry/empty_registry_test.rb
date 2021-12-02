require 'test_helper'
require 'registry/registry'

class EmptyRegistryTest < Minitest::Test

  def setup
    @registry = DuplicateFilesRegistry.new
  end

  def test_digests_returns_empty_array
    assert_equal([], @registry.digests)
  end

  def test_grouped_files_returns_empty_array
    assert_equal([], @registry.grouped_files)
  end

  def test_registry_is_empty
    assert @registry.empty?
  end

  def test_uniq_files_count_returns_zero
    assert_equal(0, @registry.uniq_files_count)
  end

  def test_add_file_adds_file_in_epmty_registry
    data_path = 'data/22.jpg'
    digest = 'c815eaafda365cf8b805fed05d6ccb04bddca917'
    @registry.add_file(digest, data_path)
    assert_equal([[data_path]], @registry.grouped_files)
  end
end
