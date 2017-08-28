require 'net/http'
require 'json'
class User < ApplicationRecord
	before_validation :generate_user_key, on: :create

	has_secure_password
	has_secure_token :key

	validates :email, presence: true, uniqueness: true, length: {maximum: 200}
	validates :phone_number, presence: true, uniqueness: true, length: {maximum: 20}
	validates :full_name, length: {maximum: 200}
	validates :key, uniqueness: true, length: {maximum: 100}
	validates :metadata, length: {maximum: 2000}

	after_create :generate_account_key


	def self.search(query)
		where("email LIKE :search OR full_name LIKE :search OR metadata LIKE :search", search: "%#{query}%")
	end

	# Generate and assign unique key
	def generate_user_key
		self.key = loop do
            random_hex = SecureRandom.urlsafe_base64
            break random_hex unless self.class.exists?(key: random_hex)
        end
	end

	def generate_account_key
		uri = URI('https://account-key-service.herokuapp.com/v1/account')
		http = Net::HTTP.new(uri.host, uri.port)
		req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
		req.body = {'email' => self.email, 'key' => self.key}.to_json
		http.use_ssl = true
		res = http.request(req)
		json_res = JSON.parse(res.body)
		unless self.class.exists?(:account_key => json_res["account_key"])
			self.update_attributes!(:account_key => json_res["account_key"])
		end
	end

end
