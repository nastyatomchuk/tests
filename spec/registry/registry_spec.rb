require 'spec_helper'
require 'registry/registry'

describe DuplicateFilesRegistry do
  context "without files registered" do
    let(:data_path ) { 'data/22.jpg' }
    let(:digest ) { 'c815eaafda365cf8b805fed05d6ccb04bddca917' }
    let(:grouped_files) { [[data_path]] }

    it "doesn`t have digests" do
      expect(subject.digests).to eql([])
    end

    it "doesn`t have grouped files" do
      expect(subject.grouped_files).to eql([])
    end

    it "is empty" do
      expect(subject.empty?).to eql(true)
    end

    it "returns 0 uniq files count" do
      expect(subject.uniq_files_count).to eql(0)
    end

    it "can add file" do
      subject.add_file(digest, data_path)

      expect(subject.grouped_files).to eql(grouped_files)
      expect(subject.digests).to eql([digest])
      expect(subject.uniq_files_count).to eql(1)
    end

    it "can iterate through each file group" do
      expect { |b| subject.each(&b) }.to yield_control.exactly(0).times
    end
  end

  context "with one file registered" do
    let(:data_path1) { 'data/22.jpg' }
    let(:digest1) { 'c815eaafda365cf8b805fed05d6ccb04bddca917' }
    let(:data_path2) { 'data/24.jpg' }
    let(:digest2) { '5678eaafda365cf8b805fed05d6ccb04bddca123' }
    let(:grouped_files) { [[data_path1], [data_path2]] }
    let(:digests) { [digest1, digest2] }
    let(:uniq_files_count) { 2 }

    before do
      subject.add_file(digest1, data_path1)
    end

    it "has one digest" do
      expect(subject.digests).to eql([digest1])
    end

    it "has one grouped file" do
      expect(subject.grouped_files).to eql([[data_path1]])
    end

    it "in`t empty" do
      expect(subject.empty?).to eql(false)
    end

    it "returns 1 uniq files count" do
      expect(subject.uniq_files_count).to eql(1)
    end

    it "can iterate through each file group" do
      expect { |b| subject.each(&b) }.to yield_control.exactly(1).times
    end

    context "when unduplicate file added" do
      it "changes uniq file count" do
        expect { subject.add_file(digest2, data_path2) }.to change { subject.uniq_files_count }.from(1).to(2)
      end

      it "changes grouped files" do
        expect { subject.add_file(digest2, data_path2) }.to change { subject.grouped_files }.from([[data_path1]]).to([[data_path1], [data_path2]])
      end

      it "changes uniq file count" do
        expect { subject.add_file(digest2, data_path2) }.to change { subject.digests }.from([digest1]).to([digest1, digest2])
      end
    end

    context "when duplicate file added" do
      it "changes uniq file count" do
        expect { subject.add_file(digest1, data_path2) }.not_to change { subject.uniq_files_count }
      end

      it "changes grouped files" do
        expect { subject.add_file(digest1, data_path2) }.to change { subject.grouped_files }.from([[data_path1]]).to([[data_path1, data_path2]])
      end

      it "changes uniq file count" do
        expect { subject.add_file(digest1, data_path2) }.not_to change { subject.digests }
      end
    end
  end

  context "with many file registered" do
    let(:data_path1) { 'data/22.jpg' }
    let(:digest1) { 'c815eaafda365cf8b805fed05d6ccb04bddca917' }
    let(:data_path2) { 'data/24.jpg' }
    let(:digest2) { '5678eaafda365cf8b805fed05d6ccb04bddca123' }
    let(:data_path3) { 'data/26.jpg' }
    let(:digest3) { '123eaafda365cf8b805fed05d6ccb07bddca8976' }
    let(:grouped_files) { [[data_path1], [data_path2]] }
    let(:digests) { [digest1, digest2] }
    let(:uniq_files_count) { 2 }

    before do
      subject.add_file(digest1, data_path1)
      subject.add_file(digest2, data_path2)
    end

    it "has many digest" do
      expect([digest1, digest2] - subject.digests).to be_empty
    end

    it "has many grouped file" do
      expect([[data_path1], [data_path2]] - subject.grouped_files).to be_empty
    end

    it "in`t empty" do
      expect(subject.empty?).to eql(false)
    end

    it "returns 1 uniq files count" do
      expect(subject.uniq_files_count).to eql(2)
    end

    it "can iterate through each file group" do
      expect { |b| subject.each(&b) }.to yield_control.exactly(2).times
    end

    context "when unduplicate file added" do
      it "changes uniq file count" do
        expect { subject.add_file(digest3, data_path3) }.to change { subject.uniq_files_count }.from(2).to(3)
      end

      it "changes grouped files" do
        expect { subject.add_file(digest3, data_path3) }.to change { subject.grouped_files }.from([[data_path1], [data_path2]]).to([[data_path1], [data_path2], [data_path3] ])
      end

      it "changes uniq file count" do
        expect { subject.add_file(digest3, data_path3) }.to change { subject.digests }.from([digest1, digest2]).to([digest1, digest2, digest3])
      end
    end

    context "when duplicate file added" do
      it "changes uniq file count" do
        expect { subject.add_file(digest2, data_path3) }.not_to change { subject.uniq_files_count }
      end

      it "changes grouped files" do
        expect { subject.add_file(digest2, data_path3) }.to change { subject.grouped_files }.from([[data_path1], [data_path2]]).to([[data_path1], [data_path2, data_path3]])
      end

      it "changes uniq file count" do
        expect { subject.add_file(digest2, data_path3) }.not_to change { subject.digests }
      end
    end
  end
end
