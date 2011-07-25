//= require jquery
//= require jquery_ujs
//= require rails.validations

if(typeof window.console === 'undefined'){
   window.console = {log: function(){return false;}};
}

$(document).ready(function() {
  
  //create auto boxes
  $(".autobox").autobox();
  
  //When page loads...
  $(".tab_content").hide(); //Hide all content
  $("ul.tabs li:first").addClass("active").show(); //Activate first tab
  $(".tab_content:first").show(); //Show first tab content

  //On Click Event
  $("ul.tabs li").click(function() {

    $("ul.tabs li").removeClass("active"); //Remove any "active" class
    $(this).addClass("active"); //Add "active" class to selected tab
    $(".tab_content").hide(); //Hide all tab content

    var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
    $(activeTab).fadeIn(); //Fade in the active ID content
    return false;
  });

	$('#slides').slides({
		preload: true,
		preloadImage: 'images/loading.gif',
		hoverPause: true
	});

  function slideSwitch() {
	  var $active = $('#slideshow IMG.active');

	  if ( $active.length == 0 ) $active = $('#slideshow IMG:last');

	  var $next =  $active.next().length ? $active.next()
	  : $('#slideshow IMG:first');

	  $active.addClass('last-active');

	  $next.css({opacity: 0.0})
	  .addClass('active')
	  .animate({opacity: 1.0}, 1000, function() {
	  $active.removeClass('active last-active');
	  });
  }
  
  if($('#slideshow img').length > 1){
    window.setInterval( slideSwitch, 5000 );
  }
  
  $('#feature a').live('click',function(){
    $('#project_thumbnail').click();
    return false;
  });
  
  if($('#showcase_holder').length > 0){
    $('#bottom_ribbon').css({
      top: ($('#showcase_holder').offset().top + $('#showcase_holder').height() - 34) + "px"
    });
  }

});
