require 'rspec'
require 'spec_helper'
require 'registry/registry'

describe DuplicateFilesRegistry do

  before do
    @registry = DuplicateFilesRegistry.new
  end

  context "digests" do
    let(:empty_array) { [] }

    it "creates empty digest array" do
      expect(@registry.digests).to eql(empty_array)
    end
  end

  context "grouped_files" do
    let(:empty_array) { [] }

    it "returns empty array" do
      expect(@registry.grouped_files).to eql(empty_array)
    end
  end

  context "empty?" do
    let(:empty) { true }

    it "returns that registry is empty" do
      expect(@registry.empty?).to eql(empty)
    end
  end

  context "uniq_files_count" do
    let(:uniq_files_count) { 0 }

    it "returns zero" do
      expect(@registry.uniq_files_count).to eql(uniq_files_count)
    end
  end

  context "add file" do
    let(:data_path ) { 'data/22.jpg' }
    let(:digest ) { 'c815eaafda365cf8b805fed05d6ccb04bddca917' }
    let(:grouped_files) { [[data_path]] }

    it "adds file in empty registry" do
      @registry.add_file(digest, data_path)
      expect(@registry.grouped_files).to eql(grouped_files)
    end
  end

  context "each" do
    xit "returns correct value" do
      expect { |b| @registry.each(&b) }.to eql(0)
    end
  end
end
