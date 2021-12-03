require 'rspec'
require 'spec_helper'
require 'registry/registry'

describe DuplicateFilesRegistry do

  before do
    @registry = DuplicateFilesRegistry.new
    @data_path1 = 'data/22.jpg'
    @digest1 = 'c815eaafda365cf8b805fed05d6ccb04bddca917'
    @registry.add_file(@digest1, @data_path1)
  end

  context "digests" do
    let(:one_file_array) { [@digest1] }

    it "returns correct array" do
      expect(@registry.digests).to eql(one_file_array)
    end
  end

  context "grouped_files" do
    let(:one_file_array) { [[@data_path1]] }

    it "returns correct array" do
      expect(@registry.grouped_files).to eql(one_file_array)
    end
  end

  context "empty?" do
    let(:not_empty) { false }

    it "returns that registry is not empty" do
      expect(@registry.empty?).to eql(not_empty)
    end
  end

  context "uniq_files_count" do
    let(:uniq_files_count) { 1 }

    it "returns count of uniq files " do
      expect(@registry.uniq_files_count).to eql(uniq_files_count)
    end
  end

  context "add file" do
    let(:data_path2 ) { 'data/23.jpg' }
    let(:digest2 ) { '1234eaafda365cf8b805fed05d6ccb04bddca666' }
    let(:grouped_files) { [[@data_path1], [data_path2]] }

    it "add file in registry with one file" do
      @registry.add_file(digest2, data_path2)
      expect(@registry.grouped_files).to eql(grouped_files)
    end
  end

  context "each" do
    it "returns correct value" do
      expect { |b| @registry.each(&b) }.to yield_successive_args([@data_path1])
    end
  end
end
