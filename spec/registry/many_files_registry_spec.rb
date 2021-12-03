require 'rspec'
require 'spec_helper'
require 'registry/registry'

describe DuplicateFilesRegistry do

  before do
    @registry = DuplicateFilesRegistry.new
    @data_path1 = 'data/22.jpg'
    @digest1 = 'c815eaafda365cf8b805fed05d6ccb04bddca917'
    @registry.add_file(@digest1, @data_path1)
    @data_path2 = 'data/23.jpg'
    @digest2 = 'a666eaafda627cf8b805fed05d6ccb04bddca920'
    @registry.add_file(@digest2, @data_path2)
  end

  context "digests" do
    let(:many_files_array) { [@digest1, @digest2] - @registry.digests }

    it "returns correct array" do
      expect(many_files_array).to be_empty
    end
  end

  context "grouped_files" do
    let(:many_files_array) { [[@data_path1], [@data_path2]] - @registry.grouped_files }

    it "returns correct array" do
      expect(many_files_array).to be_empty
    end
  end

  context "empty?" do
    let(:not_empty) { false }

    it "returns that registry is not empty" do
      expect(@registry.empty?).to eql(not_empty)
    end
  end

  context "uniq_files_count" do
    let(:uniq_files_count) { 2 }

    it "returns count of uniq files " do
      expect(@registry.uniq_files_count).to eql(uniq_files_count)
    end
  end

  context "add file" do
    let(:data_path3 ) { 'data/24.jpg' }
    let(:digest3 ) { '5678eaafda365cf8b805fed05d6ccb04bddca123' }
    let(:grouped_files) { [[@data_path1], [@data_path2], [data_path3]] }

    it "add file in registry with many file" do
      @registry.add_file(digest3, data_path3)
      expect(@registry.grouped_files).to eql(grouped_files)
    end
  end

  context "each" do
    it "returns correct value" do
      expect { |b| @registry.each(&b) }.to yield_successive_args([@data_path1], [@data_path2])
    end
  end
end
