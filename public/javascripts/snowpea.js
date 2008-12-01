$(document).ready(function() {
  $('#more-info-arrow').click(function() {
    $('#more-info').slideToggle();
    return false
  });
  
  if ($('#notice')) {
    $('#notice').fadeIn();
    
    $('#notice #close').click(function() {
      $('#notice').stop();
      $('#notice').slideUp(100);
    });
    
    return false
  }
});