require_relative '../../lib/registry/sha1_digester'

class DuplicateFilesRegistry
  def initialize
    @files = []
    @duplicate_files = Hash.new {[]}
  end

  def digests
    duplicate_files.keys
  end

  def grouped_files
    duplicate_files.values
  end

  def group_by(digest)
    grouped_files[digest]
  end

  def each
    duplicate_files.each_value { |duplicates| yield duplicates }
  end

  def empty?
    duplicate_files.empty?
  end

  def uniq_files_count
    duplicate_files.keys.count
  end

  def add_file(digest, file_path)
    return if files.include?(file_path)

    files << file_path
    duplicate_files[digest] <<= file_path
  end

  private

  attr_reader :files, :duplicate_files
end


registry = DuplicateFilesRegistry.new
data_path = File.expand_path('../../data/2.jpg', __dir__)
digester = Digest::SHA1.hexdigest(data_path)
registry.add_file(digester, data_path)

data_path = File.expand_path('../../data/3.jpg', __dir__)
digester = Digest::SHA1.hexdigest(data_path)
registry.add_file(digester, data_path)

puts registry.digests
puts registry.grouped_files
puts registry.group_by(digester.to_s.to_i)
puts registry.each
puts registry.empty?
puts registry.uniq_files_count