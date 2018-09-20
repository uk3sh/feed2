$( document ).on('turbolinks:load', function() {

  $('input[type=radio]').on('change', function () { 
    $(':radio').not(this).closest('li').removeClass('selected');
    $(this).closest('li').addClass('selected');
  });

  $('#drop').change(function() {
    console.log("hello");
    var opt = $(this).val();
    if (opt=='MCQ'){
      console.log(opt);
      $("#option-form").show();
    }

    if (opt=='Text'){
      console.log(opt);
      $("#option-form").hide();
    }

    if (opt=='Rating'){
      console.log(opt);
      $("#option-form").hide();
    }
  }); 
  
  $('.rating').rating();

  $("#form-share").steps({
    headerTag: "h3",
    bodyTag: "section",
    enableAllSteps: true,
    enablePagination: false
  });
  
});

