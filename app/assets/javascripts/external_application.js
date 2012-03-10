window.onload = function(){
    $('body').css('background', '#FFF !important');
};

$(function(){
    var rpc = window.parent.rpc;

    $('#launch').click(function(e){
	e.preventDefault();
	console.log(window.parent.rpc);
	window.parent.rpc.launchModal($(this).attr('href'));
	return false;
    });
});
