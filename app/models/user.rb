class User < ApplicationRecord

	has_secure_password

	def self.search(params)
	  where("email LIKE ?", "%#{params}%")
	  where("full_name LIKE ?", "%#{params}%")
	  where("metadata LIKE ?", "%#{params}%")
	end

	private

	def generate_user_key
		begin
			random_hash = SecureRandom.base64.tr('+/=', 'Qrt')
		end while User.exists?(api_key: random_hash)
	end

end
