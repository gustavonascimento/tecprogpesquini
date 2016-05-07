/* 
* File: enterprises.js
* Purpouse: Provides the data of javascript needed for the paginations of the pages.
* License: GPL v3
* Group 10 Tecprog
* FGA - Universidade de Brasília - Campus Gama
*/

$(function() {

  $(document).on( 'click', '.pagination a', function() {
   
    $.get( this.href, null, null, "script");
    return false;
  
  });
  
});
