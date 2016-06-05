# File: session_store.rb
# Purpouse: Stores the sessions od the application
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_pesquini_session'
