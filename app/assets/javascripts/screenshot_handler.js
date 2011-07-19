$(document).ready(function(){
  $(".screenshot_input").live('change', function(e){
    var self = $(this)
       ,file = e.target.files[0];
    
    var objectURL = getObjectURL(file);
    if(objectURL!=null)
    {
      self.parent().append('<div class="cropper"><img class="cropped_image" src="'+objectURL+'"/></div>');
      // use jQmodal and add the ^ to that div, crop and display only cropped version 
    }
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
