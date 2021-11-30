require 'test_helper'
require 'registry/registry'
require 'registry/sha1_digester.rb'

class RegistryTest < Minitest::Test

  def setup
    @registry = DuplicateFilesRegistry.new
    @digester = Sha1Digester.new

    # data_path = File.expand_path('../../data/3.jpg', __dir__)
    # @digest = digester.digest(data_path)
    # @registry.add_file(@digest, data_path)
    #
    # data_path = File.expand_path('../../data/23.jpg', __dir__)
    # @digest = digester.digest(data_path)
    # @registry.add_file(@digest, data_path)

  end

  def test_digests_returns_empty_array_when_no_files_in_registry
    assert_equal([], @registry.digests)
  end

  def test_grouped_files_returns_empty_array_when_no_files_in_registry
    assert_equal([], @registry.grouped_files)
  end

  def test_empty_returns_true_when_no_files_in_registry
    assert_equal(true, @registry.empty?)
  end

  def test_uniq_files_count_returns_zero_when_no_files_in_registry
    assert_equal(0, @registry.uniq_files_count)
  end

  def test_digests_returns_array_when_no_files_in_registry
    data_path = File.expand_path('../../data/22.jpg', __dir__)
    digest = @digester.digest(data_path)
    @registry.add_file(digest, data_path)

    assert_equal(["c815eaafda365cf8b805fed05d6ccb04bddca917"], @registry.digests)
  end

  def test_grouped_files_returns_array_when_no_files_in_registry
    data_path = File.expand_path('../../data/22.jpg', __dir__)
    digest = @digester.digest(data_path)
    @registry.add_file(digest, data_path)

    assert_equal([["C:/Users/Sad_7400/apps/tests/data/22.jpg"]], @registry.grouped_files)
  end

  def test_empty_returns_false_when_files_are_in_registry
    data_path = File.expand_path('../../data/22.jpg', __dir__)
    digest = @digester.digest(data_path)
    @registry.add_file(digest, data_path)

    assert_equal(false, @registry.empty?)
  end

  def test_uniq_files_count_returns_count_of_uniq_files_when_no_files_in_registry
    data_path = File.expand_path('../../data/22.jpg', __dir__)
    digest = @digester.digest(data_path)
    @registry.add_file(digest, data_path)

    assert_equal(1, @registry.uniq_files_count)
  end

  def test_uniq_files_grouped_files_returns_count_of_uniq_files_when_no_files_in_registry
    first_data_path = File.expand_path('../../data/22.jpg', __dir__)
    first_digest = @digester.digest(first_data_path)
    @registry.add_file(first_digest, first_data_path)
    second_data_path = File.expand_path('../../data/2.jpg', __dir__)
    second_digest = @digester.digest(second_data_path)
    @registry.add_file(second_digest, second_data_path)

    assert_equal([["C:/Users/Sad_7400/apps/tests/data/22.jpg"], ["C:/Users/Sad_7400/apps/tests/data/2.jpg"]],
                 @registry.grouped_files)
  end

  def test_registry_group_by_type_error
    data_path = File.expand_path('../../data/22.jpg', __dir__)
    digest = @digester.digest(data_path)
    @registry.add_file(digest, data_path)

    assert_raises do  @registry.group_by(digest)
    end
  end

  def test_uniq_files_each_returns_count_of_uniq_files_when_no_files_in_registry
    first_data_path = File.expand_path('../../data/22.jpg', __dir__)
    first_digest = @digester.digest(first_data_path)
    @registry.add_file(first_digest, first_data_path)
    second_data_path = File.expand_path('../../data/2.jpg', __dir__)
    second_digest = @digester.digest(second_data_path)
    @registry.add_file(second_digest, second_data_path)

    assert_equal({"c815eaafda365cf8b805fed05d6ccb04bddca917"=>["C:/Users/Sad_7400/apps/tests/data/22.jpg"],
                 "ecfacd866c94ed69bf8d810d70445adfa82858d2"=>["C:/Users/Sad_7400/apps/tests/data/2.jpg"]},
                 @registry.each{ |duplicates| puts duplicates })
  end
end
