/*
# File: show.js
# Purpouse: Javascript that loads the tabs of sanctons and payments dynamically.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama
*/

var sanctions_btn = document.getElementById("sanction-info-btn");

if ($(sanctions_btn).hasClass("active"))
{
  $(".sanction-info").html("<%= escape_javascript(render("sanctions")) %>");
}
else
{
  $(".payment-info").html("<%= escape_javascript(render("payments")) %>");
}