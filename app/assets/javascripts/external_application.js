window.onload = function(){
    $('body').css('background', '#FFF !important');
};

$(function(){
    var rpc = window.parent.rpc;

    if(typeof window.parent.rpc != 'undefined'){
	$('#launch').click(function(e){
	    e.preventDefault();
	    console.log(window.parent.rpc);
	    window.parent.rpc.launchModal($(this).attr('href'));
	    return false;
	});
    }

    if(window.parent.location.host == "embed.vidyard.com" && $("#apps_holder").length > 0){
	$('body').prepend('<h1 style="margin-bottom:10px;color:#FFF;">Get Started With Bushido. Try An App Below.</h1>');
    }

});
