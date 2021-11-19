require 'bundler/setup'
require 'minitest/autorun'
require_relative '../../lib/registry/registry'


class RegistryTest < Minitest::Test
  def test_positive_full_name_initialize

    registry = DuplicateFilesRegistry.new

    data_path = File.expand_path('data', __dir__)
    digester = Digest::SHA1.hexdigest(data_path)
    registry.add_file(digester, data_path)

  end
end
