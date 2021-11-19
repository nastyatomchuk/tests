require 'rspec'
require './spec/spec_helper.rb'
require_relative '../../lib/users/user'

describe User do
    describe 'full_name cases' do
      it 'returns full_name' do
      expect(User.new.full_name).to eql('Ivan Petroff')
      end

      it 'returns enter_full_name' do
        expect(User.new('Ivan', 'Ivanov').full_name).to eql('Ivan Ivanov')
      end

      it 'returns string type' do
      expect(User.new.full_name).to be_instance_of(String)
      end

      it 'test_default_first_name' do
        user = User.new()
        expect(user.first_name).to eql('Ivan')
      end

      it 'test_default_last_name' do
        user = User.new()
        expect(user.last_name).to eql('Petroff')
      end

      it 'test_first_name' do
        user = User.new('Petya', 'Petroff')
        expect(user.first_name).to eql('Petya')
      end

      it 'test_last_name' do
        user = User.new('Petya', 'Petroff')
        expect(user.last_name).to eql('Petroff')
      end

      it 'test_length_full_name' do
        expect(User.new('Ivan', 'Ivanov').full_name.length - 1).to eql(10)
      end
    end
end
