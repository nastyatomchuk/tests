require 'spec_helper'
require 'users/user'

describe User do
  context "when no name provided" do
    let (:default_full_name){ 'Ivan Petroff' }

    it "returns correct full name " do
      expect(subject.full_name).to eql(default_full_name)
    end
  end

  context "when all names provided" do
    let (:full_name){ 'Ivan Ivanov' }
    let(:user) { User.new('Ivan', 'Ivanov') }

    it "returns correct full name" do
      expect(user.full_name).to eql(full_name)
    end
  end

  context "when only first name provided" do
    let (:full_name){ 'Petr Petroff' }
    let(:user) { User.new('Petr') }

    it "returns correct full name" do
      expect(user.full_name).to eql(full_name)
    end
  end

  context "when empty last name provided" do
    let (:first_name){ 'Ivan' }
    let(:user) { User.new('Ivan', '') }

    it "returns correct full name" do
      expect(user.full_name).to eql(first_name)
    end
  end

  context "when nil last name provided" do
    let (:first_name){ 'Ivan' }
    let(:user) { User.new('Ivan', nil) }

    it "returns correct full name" do
      expect(user.full_name).to eql(first_name)
    end
  end

  context "when empty names provided" do
    let(:user) { User.new('', '') }

    it "raises argument error" do
      expect{ user.full_name }.to raise_error(ArgumentError)
    end
  end

  context "when nil names provided" do
    let(:user) { User.new(nil, nil) }

    it "raises argument error" do
      expect{ user.full_name }.to raise_error(ArgumentError)
    end
  end

  context "when empty first name provided" do
    let(:user) { User.new('', 'Petrov') }

    it "raises argument error" do
      expect{ user.full_name }.to raise_error(ArgumentError)
    end
  end

  context "when nil first name provided" do
    let(:user) { User.new(nil, 'Petrov') }

    it "raises argument error" do
      expect{ user.full_name }.to raise_error(ArgumentError)
    end
  end
end
