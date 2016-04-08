# File: application_helper.rb
# Purpouse: The application helper
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

module ApplicationHelper
  def flash_class(level)

    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
    
  end
end
