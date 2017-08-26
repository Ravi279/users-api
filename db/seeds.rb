# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'

10.times do |i|
	User.create!(email: FFaker::Internet.email,
				phone_number: FFaker::PhoneNumber.short_phone_number,
				full_name: FFaker::NameMX.full_name,
				password: FFaker::Internet.password,
				key: SecureRandom.hex(13),
				account_key: SecureRandom.hex(15),
				metadata: FFaker::Internet.slug)
end
