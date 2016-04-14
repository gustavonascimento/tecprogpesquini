# File: sessions_helper.rb
# Purpouse: Contains generic helper methods relative to sessions/cookies.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

module SessionsHelper

  # this method logs an user
  def sign_in user

    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user

	end

  # this method changes a current user
	def current_user=(user)

    @current_user = user

  end

  # this method returns a current user
  def current_user

	  remember_token = User.digest(cookies[:remember_token])
	  @current_user ||= User.find_by(remember_token: remember_token)

  end

  # this method returns if exists a logged user
  def signed_in?

    !current_user.nil?

  end

  # this method verify if the administrator is logged in the system
  def authorize

    redirect_to '/signin', alert: "Nao autorizado !" unless signed_in?
  
  end

  # this method logs out an user
  def sign_out

    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
    
  end
  
end
