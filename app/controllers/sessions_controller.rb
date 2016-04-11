# File: session_controller.rb
# Purpouse: Controls the actions relative to the session model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class SessionsController < ApplicationController

  def new

  end

  def create

    login = params[:session][:login].downcase
    password = params[:session][:password]
    user = User.find_by(login: login)

    if user && user.authenticate(password)
      sign_in user
      redirect_to root_path
    else
      flash[:error] = "Login ou senha invalidos!"
      render :new
    end

  end

  def destroy

    if signed_in?
      sign_out 
      redirect_to root_path
    else
      # nothing to do
    end

  end

end
