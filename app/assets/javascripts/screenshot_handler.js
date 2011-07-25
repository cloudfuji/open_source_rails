$(document).ready(function(){
  
  $('.fields a').click(function(){
    $(this).parent().find('input[type="file"]').click();
    return false;
  });

  // default crop size. We don't want to use a global var and dirty stuff
  $(document).data('crop_id', 'logo');

  // $image_holder = $('body').append('<img class="cropbox" id="image_holder" src=""/>');
  
  $(".screenshot_input, #project_thumbnail").live('change', function(e){
    var self = $(this)
       ,file = e.target.files[0];
    
    var objectURL = getObjectURL(file);
   
    // if browser supports HTML5 FileAPI
    if(objectURL!=null){
      
      var jcrop_api;
      
      $.colorbox({
        photo: true
        ,title: "Please crop your image to this size. When finished, close the window or press the ESC key"
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
              $(document).data('crop_id', self.parent().prevAll().length);
              size_x = 938;
              size_y = 455;
            }else{
              $(document).data('crop_id', "logo");
              size_x = 150;
              size_y = 150;
            }
            
 
            jcrop_api = $.Jcrop('.cboxPhoto');
            jcrop_api.setOptions({
                minSize: [ size_x, size_y ],
                maxSize: [ size_x, size_y ],
                setSelect: [0, 0, size_x, size_y],
                onSelect: function(coords) {
                  console.log("jcrop select");
                  var crop_id = $(document).data('crop_id');
                  if(crop_id=="logo"){
                    var $logo_input = $("#project_thumbnail");
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
            
            jcrop_api.setOptions({allowResize: false});
            window.setTimeout(function(){$.colorbox.resize();}, 1000);
      }});
    }
  });

  $('#project_source_url').change(checkRepoAuthorInfo);
  
  function checkRepoAuthorInfo() {
    var pattern = /^(http(s)?:\/\/github\.com\/).+(\/).+(\.git)$/
       ,repo_url = $("#project_source_url").val();
    
    if(pattern.test(repo_url)){
      var repoString = repo_url.replace(/^http(s)?:\/\/github\.com\//i, "").replace(/\.git$/i, "");
      console.log(repoString);
      setAuthorRepoInfo(repoString);
    }
  }
 
  function setAuthorRepoInfo(repoString) {
    $.get('/projects/github_info/'+repoString+'.json'
          ,data = {}
          ,success = function(data, textStatus, xhr) {
            if(data['repository']!=undefined){
              var repo = data['repository']
                 ,author = repo['owner']
                 ,authorURL = "https://github/"+author;
              $('#project_author_attributes_name').val(author);
              $('#project_author_attributes_url').val(authorURL);
              $('.app_author_link').html("<a href='"+authorURL+"'>"+author+"</a>");
            }
          });
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

  // TODO init calls. Need a better way to write this. Will clean up later. Just work now!
  checkRepoAuthorInfo();  // check author info on load; Useful for edit view

});

