require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "Users API" do
    before do
      FactoryGirl.create(:user, :email => 'user1@example.com', :phone_number => '8765678976',
                         :full_name => "User1 Hello", :password_digest => "passwrod1", :metadata => "male, age 32, unemployed, college-educated")
      FactoryGirl.create(:user, :email => 'user2@example.com', :phone_number => '8765678986',
                         :full_name => "User2 Hello", :password_digest => "passwrod2", :metadata => "male, age 32, unemployed, college-educated")
    end

    it 'sends a list of users' do

      get '/api/v1/users.json'

      users = JSON.parse(response.body)

      # test for the 200 status-code
      expect(response).to be_success

      # check to make sure the right amount of messages are returned
      expect(users.length).to eq(2)
    end

    it 'sends a list of users match with query' do

      get '/api/v1/users.json?query=User2'

      users = JSON.parse(response.body)

      # test for the 200 status-code
      expect(response).to be_success

      # check to make sure the right amount of messages are returned
      expect(users.length).to eq(1)
    end

    it "creates a new user" do
      request_headers = {
          "Accept" => "application/json",
          "Content-Type" => "application/json"
      }
      user_params = { "user" => {"email" => 'user3@example.com', "phone_number" => '8764678976',
                               "full_name" => "User3 Hello", "password_digest" => "passwrod3", "metadata" => "male, age 32, unemployed, college-educated" } }
      post "/api/v1/users.json", params: user_params
      expect(JSON.parse(response.body).except!('key', 'account_key')).to eq(user_params["user"].except!("password_digest"))
    end

    it "creates a new user with validation errors" do
      request_headers = {
          "Accept" => "application/json",
          "Content-Type" => "application/json"
      }
      user_params = { "user" => {"email" => 'user1@example.com', "phone_number" => '8764678976',
                                 "full_name" => "User3 Hello", "password_digest" => "passwrod3", "metadata" => "male, age 32, unemployed, college-educated" } }
      post "/api/v1/users.json", params: user_params
      expect(JSON.parse(response.body)['errors']["email"]).to eq(["has already been taken"])
    end
  end
end
