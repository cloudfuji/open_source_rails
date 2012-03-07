window.onload = function(){
    $('body').css('background', '#FFF !important');
};

$(function(){
    var rpc = window.parent.rpc;
    console.log(window.parent.location);
    console.log(window.parent.rpc);
    console.log(rpc);
    $('#launch').click(function(e){
	e.preventDefault();
	console.log("app launch click detected rpc call");
	console.log(window.parent.rpc, window.parent.rpc.loginModal);
	window.parent.rpc.loginModal();
	return false;
    });
});
