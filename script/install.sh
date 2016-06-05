# File: install,sh
# Purpouse: Script that install the database on the system.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

#!/bin/sh
sudo apt-get install postgresql -y

sudo apt-get install libpq-dev nodejs -y

sudo service postgresql start
sudo -u postgres psql -c "DROP DATABASE pesquini_development" || true
sudo -u postgres psql -c "DROP DATABASE pesquini_test" || true
sudo -u postgres psql -c "DROP USER pesquini" || true
sudo -u postgres psql -c "CREATE USER pesquini CREATEDB CREATEROLE INHERIT LOGIN" || true
sudo -u postgres psql -c "CREATE DATABASE pesquini_development WITH OWNER = pesquini" || true
sudo -u postgres psql -c "CREATE DATABASE pesquini_test WITH OWNER = pesquini" || true
bundle install
sudo -u postgres psql -d pesquini_development -f ../pesquini_development.sql
sudo -u postgres psql -d pesquini_test -f ../pesquini_development.sql
