$(document).ready(function() {
  $('#more-info-arrow').click(function() {
    $('#more-info').slideToggle();
    return false
  });
  
  if ($('#notice')) {
    $('#notice').fadeIn().animate({ opacity: 1.0 }, 2000
    ).animate({
      opacity: 0.6
    });
    
    $('#notice #close').click(function() {
      $('#notice').stop();
      $('#notice').slideUp(100);
    });
    
    return false
  }
});