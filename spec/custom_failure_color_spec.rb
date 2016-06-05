# File: custom_failure_color_spec.rb
# Purpouse: gives color to the errors when shwon in the terminal.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

RSpec.configure do |config|
  config.failure_color = :magenta
  config.tty = true
  config.color = true
end
