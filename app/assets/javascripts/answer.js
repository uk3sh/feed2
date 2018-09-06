$( document ).on('turbolinks:load', function() {

  $('input[type=radio]').on('change', function () { 
    $(':radio').not(this).closest('li').removeClass('selected');
    $(this).closest('li').addClass('selected');
  });
  
});

