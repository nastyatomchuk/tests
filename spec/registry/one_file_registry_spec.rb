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
    let(:data_path3 ) { 'data/24.jpg' }
    let(:digest3 ) { '5678eaafda365cf8b805fed05d6ccb04bddca123' }
    let(:grouped_files) { [[@data_path1], [data_path3]] }
    let(:digests) { [@digest1, digest3] }
    let(:uniq_files_count) { 2 }

    it "adds unduplicate file in registry with one file" do
      @registry.add_file(digest3, data_path3)
      expect(@registry.grouped_files).to eql(grouped_files)
      expect(@registry.digests).to eql(digests)
      expect(@registry.uniq_files_count).to eql(uniq_files_count)
    end
  end

  context "add file" do
    let(:data_path3 ) { 'data/24.jpg' }
    let(:digest3 ) { 'c815eaafda365cf8b805fed05d6ccb04bddca917' }
    let(:grouped_files) { [[@data_path1, data_path3]] }
    let(:digests) { [@digest1] }
    let(:uniq_files_count) { 1 }

    it "adds duplicate file in registry with one file" do
      @registry.add_file(digest3, data_path3)
      expect(@registry.grouped_files).to eql(grouped_files)
      expect(@registry.digests).to eql(digests)
      expect(@registry.uniq_files_count).to eql(uniq_files_count)
    end
  end

  context "each" do
    it "returns correct value" do
      yielded = []
      @registry.each do |e| yielded << e end
      expect(yielded.count).to eq(1)
    end
  end
end
