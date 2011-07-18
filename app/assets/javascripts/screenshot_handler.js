$(document).ready(function(){
  $(".screenshot_input").change(function(e){
    var file = e.target.files[0];
    var objectURL=null;
    console.log(file);
    
    console.log(getObjectURL(file));

  });  
});

function getObjectURL(fileObj) {
  console.log("called");
    if((typeof window.URL!=="undefined") && (typeof window.URL.createObjectURL=="function"))
    {
      //Firefox 3.6+ and Opera
      console.log("FF", fileObj);
      return window.URL.createObjectURL(file);
    }
    else if((typeof window.webkitURL != "undefined") && (typeof window.webkitURL.createObjectURL=="function"))  //Chrome 10+
    {
      console.log("Chrome",fileObj);
      return window.webkitURL.createObjectURL(fileObj);
    }
    return null;
}
