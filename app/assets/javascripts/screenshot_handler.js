$(document).ready(function(){
  $(".screenshot_input").change(function(e){
    var file = e.target.files[0];
    var objectURL=null;
    console.log(file);
    console.log(getObjectURL(file));

  });  
});

function getObjectURL(obj) {
  if((typeof window.URL!=="undefined") && (typeof window.URL.createObjectURL=="function"))
  {
    //Firefox 3.6+ and Opera
    console.log("FF", obj);
    return window.URL.createObjectURL(obj);
  }
  else if((typeof window.webkitURL != "undefined") && (typeof window.webkitURL.createObjectURL=="function"))  //Chrome 10+
  {
    console.log("Chrome", obj);
    return window.webkitURL.createObjectURL(obj);
  }
  return null;
}
