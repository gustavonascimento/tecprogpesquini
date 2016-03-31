 $(document ).ready(function ( ) {

    var select_b = document.getElementById('select_button');
    if (select_b)
    {
      select_b.style.display = "none";
    }

    $('#select_tag').change(function() {
    $(this).closest('form').trigger('submit');
    });

});
