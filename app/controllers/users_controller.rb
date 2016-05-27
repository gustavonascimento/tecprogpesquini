# File: users_controller.rb
# Purpouse: Controls the actions relative to the user model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class UsersController < ApplicationController

  # makes a new user
  # @param @user
  def new

  	# stores the user, used for the parser login.
    @user = User.new

    return @user

    Preconditions.check_not_nil(@user)
    
  end
  
end
