require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User attribute validations' do

    it 'should validate email presence' do
      record = User.new
      record.email = '' # invalid state
      record.valid? # run validations
      record.errors[:email].should include("can't be blank") # check for presence of error

      record.email = 'foo@bar.com' # valid state
      record.valid? # run validations
      record.errors[:email].should_not include("can't be blank") # check for absence of error
    end

    it 'should validate phone_number presence' do
      record = User.new
      record.phone_number = '' # invalid state
      record.valid? # run validations
      record.errors[:phone_number].should include("can't be blank") # check for presence of error

      record.phone_number = '8764678976' # valid state
      record.valid? # run validations
      record.errors[:phone_number].should_not include("can't be blank") # check for absence of error
    end

  end

  describe 'Valid User record creation' do

    it 'should create user and add the account_key' do
      record = User.new("email" => 'user3@example.com', "phone_number" => '8764678976',
                        "full_name" => "User3 Hello", "password" => "passwrod3", "metadata" => "male, age 32, unemployed, college-educated")
      record.valid? # run validations

      record.valid? # run validations
      expect(record.errors.size).to eq(0)
      expect(record.account_key.present?).to be_falsey
      record.save!
      expect(record.account_key.present?).to be_truthy
    end

  end

  describe '#search' do

    it 'should return valid user' do
      user2 = FactoryGirl.create(:user, :email => 'user2@example.com', :phone_number => '8765678986',
                         :full_name => "User2 Hello", :password => "passwrod2", :metadata => "male, age 32, unemployed, college")
      user1 = FactoryGirl.create(:user, :email => 'user1@example.com', :phone_number => '8765678976',
                         :full_name => "User1 Hello", :password => "passwrod1", :metadata => "male, age 32, unemployed, college-educated")

      expect(User.search('college-educated').first).to eq(user1)
    end

  end
end
