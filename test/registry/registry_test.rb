require 'bundler/setup'
require 'minitest/autorun'
require_relative '../../lib/registry/registry'

class DuplicateFilesRegistry_Test < Minitest::Test

  def setup
    @registry = DuplicateFilesRegistry.new
    data_path = File.expand_path('../../data/', __dir__)
    digester = Sha1Digester.new
    file_names = Dir.entries(data_path).select {|f| !File.directory? f}

    file_names.each  do |file_name|
      full_file_name = File.join( data_path , file_name)
      digest = digester.digest(full_file_name)
      @registry.add_file(digest, full_file_name)
    end
  end

  def test_positive_registry_digests
    assert_equal(["ecfacd866c94ed69bf8d810d70445adfa82858d2",
                  "c815eaafda365cf8b805fed05d6ccb04bddca917",
                  "341170e3a4c2e5f0e1587de9d94e87be77c76ee8",
                  "0281e9239cc465e66b197c71af1c46c116360d20"], @registry.digests)
  end

  def test_registry_grouped_files
    assert_equal([["C:/Users/Sad_7400/apps/tests/data/2.jpg"],
                  ["C:/Users/Sad_7400/apps/tests/data/22.jpg", "C:/Users/Sad_7400/apps/tests/data/222.jpg", "C:/Users/Sad_7400/apps/tests/data/23.jpg"],
                  ["C:/Users/Sad_7400/apps/tests/data/3.jpg", "C:/Users/Sad_7400/apps/tests/data/34.jpg"],
                  ["C:/Users/Sad_7400/apps/tests/data/4.jpg"]], @registry.grouped_files)
  end

  def test_registry_group_by_type_error
    assert_raises do  @registry.group_by(@digest)
    end
  end

  def test_registry_each
    assert_equal({"ecfacd866c94ed69bf8d810d70445adfa82858d2"=>["C:/Users/Sad_7400/apps/tests/data/2.jpg"],
                  "c815eaafda365cf8b805fed05d6ccb04bddca917"=>["C:/Users/Sad_7400/apps/tests/data/22.jpg", "C:/Users/Sad_7400/apps/tests/data/222.jpg", "C:/Users/Sad_7400/apps/tests/data/23.jpg"],
                  "341170e3a4c2e5f0e1587de9d94e87be77c76ee8"=>["C:/Users/Sad_7400/apps/tests/data/3.jpg", "C:/Users/Sad_7400/apps/tests/data/34.jpg"],
                  "0281e9239cc465e66b197c71af1c46c116360d20"=>["C:/Users/Sad_7400/apps/tests/data/4.jpg"]}, @registry.each{ |duplicates| puts duplicates })
  end

  def test_registry_empty
    assert_equal(false ,  @registry.empty?)
  end

  def test_uniq_files_count
    assert_equal(4 ,  @registry.uniq_files_count)
  end
end
