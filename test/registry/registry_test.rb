require 'bundler/setup'
require 'minitest/autorun'
require_relative '../../lib/registry/registry'
require_relative '../../lib/registry/sha1_digester.rb'

class RegistryTest < Minitest::Test

  def setup
    @registry = DuplicateFilesRegistry.new
    digester = Sha1Digester.new

    data_path = File.expand_path('../../data/22.jpg', __dir__)
    @digest = digester.digest(data_path)
    @registry.add_file(@digest, data_path)

    data_path = File.expand_path('../../data/3.jpg', __dir__)
    @digest = digester.digest(data_path)
    @registry.add_file(@digest, data_path)

    data_path = File.expand_path('../../data/23.jpg', __dir__)
    @digest = digester.digest(data_path)
    @registry.add_file(@digest, data_path)

  end

  def test_registry_digests_is_array
    assert_instance_of(Array,  @registry.digests)
  end

  def test_positive_registry_digests
    assert_equal(["c815eaafda365cf8b805fed05d6ccb04bddca917", "341170e3a4c2e5f0e1587de9d94e87be77c76ee8"], @registry.digests)
  end

  def test_registry_grouped_files_is_array
    assert_instance_of(Array,  @registry.grouped_files)
  end

  def test_registry_grouped_files
    assert_equal([["C:/Users/Sad_7400/apps/tests/data/22.jpg", "C:/Users/Sad_7400/apps/tests/data/23.jpg"], ["C:/Users/Sad_7400/apps/tests/data/3.jpg"]], @registry.grouped_files)
  end

  def test_registry_group_by_type_error
    assert_raises do  @registry.group_by(@digest)
    end
  end

  def test_duplicate_files_is_hash
    assert_instance_of(Hash,  @registry.each{ |duplicates| puts duplicates })
  end

  def test_registry_each
    assert_equal({"c815eaafda365cf8b805fed05d6ccb04bddca917"=>["C:/Users/Sad_7400/apps/tests/data/22.jpg", "C:/Users/Sad_7400/apps/tests/data/23.jpg"], "341170e3a4c2e5f0e1587de9d94e87be77c76ee8"=>["C:/Users/Sad_7400/apps/tests/data/3.jpg"]},  @registry.each{ |duplicates| puts duplicates })
  end

  def test_registry_empty
    assert_equal(false ,  @registry.empty?)
  end

  def test_uniq_files_count
    assert_equal(2 ,  @registry.uniq_files_count)
  end
end
