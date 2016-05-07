/* 
* File: enterprises.js
* Purpouse: Provides the data of javascript needed for the scrolling of the pages.
* License: GPL v3
* Group 10 Tecprog
* FGA - Universidade de Brasília - Campus Gama
*/

$(function() {
  
  $('a[href*=#]:not([href=#])').click(function() {
    
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
     
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
     
      if (target.length) {
        
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000);
        return false;
      
      } 
      else {
        //nothig to do
      
      }
    
    }
  
  });

});
