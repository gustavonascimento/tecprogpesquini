# File: application_controller.rb
# Purpouse: Allows the integration between controllers and views, 
# ... raising an exception in the case of the application doesn't start right.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class ApplicationController < ActionController::Base
  
  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  rescue_from ActionController::RoutingError, :with => :render_not_found

  # sends a message in case the application has a routing problem.
  def raise_not_found!

    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")

  end

  # displays an error if the render isn't found.
  def render_not_found

    respond_to do |f|
      f.html{ render :template => "errors/404", :status => 404 }
    end

  end
  
end
