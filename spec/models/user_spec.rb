require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#email' do

    it 'should validate presence' do
      record = User.new
      record.email = '' # invalid state
      record.valid? # run validations
      record.errors[:email].should include("can't be blank") # check for presence of error

      record.email = 'foo@bar.com' # valid state
      record.valid? # run validations
      record.errors[:email].should_not include("can't be blank") # check for absence of error
    end

    it 'should create user and add the account_key' do
      record = User.new("email" => 'user3@example.com', "phone_number" => '8764678976',
                        "full_name" => "User3 Hello", "password_digest" => "passwrod3", "metadata" => "male, age 32, unemployed, college-educated")
      record.valid? # run validations

      record.valid? # run validations
      expect(record.errors.size).to eq(0)
      expect(record.account_key.present?).to be_falsey
      record.save!
      expect(record.account_key.present?).to be_truthy
    end


  end
end
