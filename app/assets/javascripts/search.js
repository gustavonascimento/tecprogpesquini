 $(document ).ready(function ( ) {
  var element = document.getElementById('enterprises_index');
  if (element)
  {
  var element1 = element.getElementsByClassName("fa_search")[0];
  var search1 = element.getElementsByClassName("search_form_enterprises")[0];
  }
  $(element).on('click', function () {
    $(search1).removeClass("off");
    $(element1).addClass('off');
  });

});