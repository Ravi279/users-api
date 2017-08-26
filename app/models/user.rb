class User < ApplicationRecord

	has_secure_password

	def self.search(query)
		where("email LIKE :search OR full_name LIKE :search OR metadata LIKE :search", search: "%#{query}%")
	end

	private

	def generate_user_key
		begin
			random_hash = SecureRandom.hex(13)
		end while User.exists?(api_key: random_hash)
	end

end
