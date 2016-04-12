# File: user.rb
# Purpouse: The user model, receives the information from user.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class User < ActiveRecord::Base

	has_secure_password
	validates :login, length: { maximum: 50, minimum: 5 }, uniqueness: { case_sensitive: false }, allow_blank: false
	validates :password, length: { minimum: 8 }, allow_blank: false

	# generates a token for password.
	def User.new_remember_token

		SecureRandom.urlsafe_base64
	
	end
	
	# compile the token.
	def User.digest(token)

		Digest::SHA1.hexdigest(token.to_s)

	end

end
