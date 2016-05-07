/* 
* File: enterprises.js
* Purpouse: Provides the data of javascript needed for the search function.
* License: GPL v3
* Group 10 Tecprog
* FGA - Universidade de Brasília - Campus Gama
*/

 $(document ).ready(function ( ) {
  
  var element = document.getElementById('enterprises_index');
  
  if (element) {
  
  var element1 = element.getElementsByClassName("fa_search")[0];
  var search1 = element.getElementsByClassName("search_form_enterprises")[0];
  
  }
  
  else {
    
    //nothing to do
  
  }

  $(element).on('click', function () {
  
    $(search1).removeClass("off");
    $(element1).addClass('off');
  
  });

});
 