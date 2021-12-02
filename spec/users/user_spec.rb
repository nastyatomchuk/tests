require 'rspec'
require 'spec_helper'
require 'users/user'

describe User do

  context "full_name" do
    let (:full_name){ 'Ivan Petroff' }
    let(:user) { User.new }

    it "returns correct value when no name provided" do
      expect(user.full_name).to eql(full_name)
    end
  end

  context "full_name" do
    let (:full_name){ 'Ivan Ivanov' }
    let(:user) { User.new('Ivan', 'Ivanov') }

    it "returns correct value when all names provided" do
      expect(user.full_name).to eql(full_name)
    end
  end

  context "full_name" do
    let(:user) { User.new('Ivan', 'Ivanov') }

    it "returns string type" do
      expect(user.full_name).to be_instance_of(String)
    end
  end

  context "full_name" do
    let (:full_name){ 'Petr Petroff' }
    let(:user) { User.new('Petr') }

    it "returns correct value when only first name provided" do
      expect(user.full_name).to eql(full_name)
    end
  end

  context "full_name" do
    let (:first_name){ 'Ivan' }
    let(:user) { User.new('Ivan', '') }

    it "returns correct value when empty last name provided" do
      expect(user.full_name).to eql(first_name)
    end
  end

  context "full_name" do
    let (:first_name){ 'Ivan' }
    let(:user) { User.new('Ivan', nil) }

    it "returns correct value when nil last name provided" do
      expect(user.full_name).to eql(first_name)
    end
  end

  context "user last name " do
    let(:user) { User.new('', '') }

    it "raises argument error when empty names provided" do
      expect{ user.full_name }.to raise_error(ArgumentError)
    end
  end

  context "user last name " do
    let(:user) { User.new('', '') }

    it "raises argument error when nil names provided" do
      expect{ user.full_name }.to raise_error(ArgumentError)
    end
  end
end
