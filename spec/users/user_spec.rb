require 'rspec'

require_relative '../../spec/spec_helper'

# require './spec/spec_helper'ls
require_relative '../../lib/users/user'


describe User do

  context "new user" do
    let (:full_name){ 'Ivan Petroff' }
    let(:user) { User.new }

    it "makes a user with name Ivan Petrov" do
      expect(user.full_name).to eql(full_name)
    end
  end

  context "new user with full name" do
    let (:full_name){ 'Ivan Ivanov' }
    let(:user) { User.new('Ivan', 'Ivanov') }

    it "makes a user with name Ivan Ivanov" do
      expect(user.full_name).to eql(full_name)
    end
  end

  context "full name is string" do
    let(:user) { User.new('Ivan', 'Ivanov') }

    it "returns string type" do
      expect(user.full_name).to be_instance_of(String)
    end
  end

  context "default user first name " do
    let (:first_name){ 'Ivan' }
    let(:user) { User.new }

    it "returns default user first name" do
      expect(user.first_name).to eql(first_name)
    end
  end

  context "default user last name " do
    let (:first_name){ 'Petroff' }
    let(:user) { User.new }

    it "returns default user last name" do
      expect(user.last_name).to eql(first_name)
    end
  end

  context "user last name " do
    let (:first_name){ 'Petya' }
    let(:user) { User.new('Petya', 'Petroff') }

    it "returns user last name" do
      expect(user.first_name).to eql(first_name)
    end
  end

  context "user last name " do
    let (:last_name){ 'Petroff' }
    let(:user) { User.new('Petya', 'Petroff') }

    it "returns user last name" do
      expect(user.last_name).to eql(last_name)
    end
  end

  context "full name length" do
    let (:count){ 12 }
    let(:user) { User.new('Petya', 'Petroff') }

    it "returns the number of characters in the full name " do
      expect(user.full_name.length - 1).to eql(count)
    end
  end
end
