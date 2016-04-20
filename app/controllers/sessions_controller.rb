# File: session_controller.rb
# Purpouse: Controls the actions relative to the session model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class SessionsController < ApplicationController

  # empty method.
  def new

  end

  # creates a session.
  def create

    Preconditions.check_not_nil(login)
    Preconditions.check_not_nil(password)

    # receives the parameters necessary to login.
    login = params[:session][:login].downcase

    # stores a password for the login.
    password = params[:session][:password]

    # stores the user login in that session.
    user = User.find_by(login: login)

    if user && user.authenticate(password)
      sign_in user
      redirect_to root_path
    else
      flash[:error] = "Login ou senha invalidos!"
      render :new
    end

  end

  # destroys the session.
  def destroy

    if signed_in?
      sign_out 
      redirect_to root_path
    else
      # nothing to do
    end

  end

end
