require 'rspec'
require './spec/spec_helper.rb'
require_relative '../../lib/registry/registry'

describe DuplicateFilesRegistry do
  let(:registry) { DuplicateFilesRegistry.new }

  before do
    data_path = File.expand_path('../../data/', __dir__)
    digester = Sha1Digester.new
    file_names = Dir.entries(data_path).select {|f| !File.directory? f}

    file_names.each  do |file_name|
      full_file_name = File.join( data_path , file_name)
      digest = digester.digest(full_file_name)
      registry.add_file(digest, full_file_name)
    end
  end

  context "digests" do
    it "creates digest array" do
      expect(registry.digests).to eql(["ecfacd866c94ed69bf8d810d70445adfa82858d2",
                                       "c815eaafda365cf8b805fed05d6ccb04bddca917",
                                       "341170e3a4c2e5f0e1587de9d94e87be77c76ee8",
                                       "0281e9239cc465e66b197c71af1c46c116360d20"])
    end
  end

  context "grouped_files" do
    it "groups files into arrays by keysy" do
      expect(registry.grouped_files).to eql([["C:/Users/Sad_7400/apps/tests/data/2.jpg"],
                                             ["C:/Users/Sad_7400/apps/tests/data/22.jpg", "C:/Users/Sad_7400/apps/tests/data/222.jpg", "C:/Users/Sad_7400/apps/tests/data/23.jpg"],
                                             ["C:/Users/Sad_7400/apps/tests/data/3.jpg", "C:/Users/Sad_7400/apps/tests/data/34.jpg"],
                                             ["C:/Users/Sad_7400/apps/tests/data/4.jpg"]])
    end
  end

  context "grouped_files(digest)" do
    let(:digest) { "c815eaafda365cf8b805fed05d6ccb04bddca917" }
    xit "outputs files with the corresponding digest" do
      expect(registry.group_by(digest)).to raise_error
    end
  end

  context "each" do
    it "displays digests and files that correspond to them" do
      expect(registry.each{ |duplicates| puts duplicates }).to eql({"ecfacd866c94ed69bf8d810d70445adfa82858d2"=>["C:/Users/Sad_7400/apps/tests/data/2.jpg"],
                                                                    "c815eaafda365cf8b805fed05d6ccb04bddca917"=>["C:/Users/Sad_7400/apps/tests/data/22.jpg", "C:/Users/Sad_7400/apps/tests/data/222.jpg", "C:/Users/Sad_7400/apps/tests/data/23.jpg"],
                                                                    "341170e3a4c2e5f0e1587de9d94e87be77c76ee8"=>["C:/Users/Sad_7400/apps/tests/data/3.jpg", "C:/Users/Sad_7400/apps/tests/data/34.jpg"],
                                                                    "0281e9239cc465e66b197c71af1c46c116360d20"=>["C:/Users/Sad_7400/apps/tests/data/4.jpg"]})
    end
  end

  context "empty?" do
    let(:result) { false }
    it "checks if case is empty" do
      expect(registry.empty?).to eql(result)
    end
  end

  context "uniq_files_count" do
    let(:uniq_files_count) { 4 }
    it "counts the number of unique filesy" do
      expect(registry.uniq_files_count).to eql(uniq_files_count)
    end
  end
end
