# File: users_controller.rb
# Purpouse: Controls the actions relative to the user model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class UsersController < ApplicationController

  # makes a new user
  def new

  	# stores the user, used for the parser login.
    @user = User.new
    
  end
  
 end
