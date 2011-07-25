//NOTES: replace this to use document data
var crop_id="logo";

$(document).ready(function(){
  
  //$('body').prepend('<div class="cropwrap"></div>');
  //var $image_holder = $('body').append('<img class="cropbox" id="image_holder" src=""/>');
  
  $('.fields a').click(function(){
    $(this).parent().find('input[type="file"]').click();
    return false;
  });
  
  //$(".cropwrap").jqm({modal: true});
  
  $(".screenshot_input, .logo_input").live('change', function(e){
    var self = $(this)
       ,file = e.target.files[0];
    
    var objectURL = getObjectURL(file);
    
    if(objectURL!=null){
      
      var jcrop_api;
      // $.modal('<img class="cropbox" src="'+objectURL+'"/>'
      //               , {
      //                   escClose: true
      //                  ,overlayClose: true
      //                  ,autoPosition: true
      //                  ,autoResize: true
      //                  //,position: ["1%", "1%"]
      //                  });
      
      $.colorbox({
        photo: true
        ,title: "Please crop your image to this size. Close the window when finished"
        ,overlayClose: false
        ,escKey: true
        ,href: objectURL
        ,onClosed: function(){
          /*
          *
          * we need to trigger jcrops select event here but there dosen't appear to be a default way to do it
          *
          */
          console.log("modal box closing", jcrop_api.tellSelect(), jcrop_api);
          //jcrop_api.select();

        }
        ,onComplete: function(){
            var size_x, size_y;
      
            if (self.attr('class')=="screenshot_input"){
              console.log("alert screenshot_input class");
              console.log(self.parent(), self.parent().prevAll(), self.parent().prevAll().length);
              crop_id = self.parent().prevAll().length;
              size_x = 938;
              size_y = 455;
            }else{
              crop_id = "logo";
              size_x = 150;
              size_y = 150;
            }
            
            console.log("alert crop_id?", crop_id);
 
            jcrop_api = $.Jcrop('.cboxPhoto');
            jcrop_api.setOptions({
                minSize: [ size_x, size_y ],
                maxSize: [ size_x, size_y ],
                setSelect: [0, 0, size_x, size_y],
                onSelect: function(coords) {
                  console.log("jcrop select");
                  console.log(crop_id);
                  if(crop_id =="logo"){
                    var $logo_input = $(".logo_input:first");
                    $logo_input.parent().find('#crop_x').val(coords.x);
                    $logo_input.parent().find('#crop_y').val(coords.y);
                    $logo_input.parent().find('#crop_w').val(coords.w);
                    $logo_input.parent().find('#crop_h').val(coords.h);
                    if($('#feature').find('#logo_thumbnail').length < 1){
                      $('#feature').find('p').hide();
                      $('#feature').append('<a style="display:block;width:150px;height:150px;overflow:hidden;"><img id="logo_thumbnail" src="'+objectURL+'"/></a>');
                    }
                    $('#logo_thumbnail').attr('src', objectURL);
                      var rx = size_x / coords.w;
                    	var ry = size_y / coords.h;

                    	$('#logo_thumbnail').css({
                    		width: Math.round(rx * $('.cboxPhoto').width()) + 'px',
                    		height: Math.round(ry * $('.cboxPhoto').height()) + 'px',
                    		marginLeft: '-' + Math.round(rx * coords.x) + 'px',
                    		marginTop: '-' + Math.round(ry * coords.y) + 'px'
                    	});
                  }else{
                    console.log("omg croppan a screenshot");
                    var $screenshot_input = $(".screenshot_input")
                        ,$container = $screenshot_input.eq(crop_id).parent()
                        ,$link = $container.find('a');
                        
                    console.log("What are we working with? container =",$container, "link", $link, $link.find('.screener'));
                    
                    if($link.find('.screener').length < 1){
                      $link.html('<img class="screener" src="'+objectURL+'"/>');
                    }
                    
                    console.log("settinf values for crop_Id", crop_id);
                    
                    $screenshot_input.eq(crop_id).parent().find('#crop_x').val(coords.x);
                    $screenshot_input.eq(crop_id).parent().find('#crop_y').val(coords.y);
                    $screenshot_input.eq(crop_id).parent().find('#crop_w').val(coords.w);
                    $screenshot_input.eq(crop_id).parent().find('#crop_h').val(coords.h);
                    
                    $link.find('.screener').attr('src', objectURL);
                    var rx = size_x / coords.w;
                  	var ry = size_y / coords.h;

                  	$link.find('.screener').css({
                  		width: Math.round(rx * $('.cboxPhoto').width()) + 'px',
                  		height: Math.round(ry * $('.cboxPhoto').height()) + 'px',
                  		marginLeft: '-' + Math.round(rx * coords.x) + 'px',
                  		marginTop: '-' + Math.round(ry * coords.y) + 'px'
                  	});
                  }
                }
            });
            
            //$('.cropwrap').jqmShow();
            jcrop_api.setOptions({allowResize: false});
            window.setTimeout(function(){$.colorbox.resize();}, 1000);
      }});
    }
  });



  $('.source_url').change(function(e) {
    var pattern = /^(http(s)?:\/\/github\.com\/).+(\/).+(\.git)$/
       ,repo_url = $(this).val();
    
    if(pattern.test(repo_url)){
      var repoString = repo_url.replace(/^http(s)?:\/\/github\.com\//i, "").replace(/\.git$/i, "");
      setRepoInfo(repoString);
    }
  });

  function setRepoInfo(repoString) {
    $.get('/projects/github_info/'+repoString+'.json'
          ,data = {}
          ,success = function(data, textStatus, xhr) {
            if(data['repository']!=undefined){
              var repo = data['repository']
                 ,author = repo['owner']
                 ,authorURL = "https://github/"+author;
              $('.app_author').val(author);
              $('.app_author_url').val(authorURL);
              $('.app_author_link').html("<a href='"+authorURL+"'>"+author+"</a>");
            }
          }
    );
  }

  function getObjectURL(obj) {
    if((typeof window.URL!=="undefined") && (typeof window.URL.createObjectURL=="function")){
      //Firefox 3.6+ and Opera
      return window.URL.createObjectURL(obj);
    }else if((typeof window.webkitURL != "undefined") && (typeof window.webkitURL.createObjectURL=="function")){//Chrome 10
      return window.webkitURL.createObjectURL(obj);
    }
    return null;
  }

});

