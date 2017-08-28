FactoryGirl.define do
  factory :user do
    email "user@example.com"
    phone_number "6776768686"
    full_name "User Hello"
    password_digest "password123"
    metadata "male, age 32, unemployed, college-educated"
  end
end
