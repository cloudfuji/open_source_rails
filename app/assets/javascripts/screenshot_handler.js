var crop_id;

$(document).ready(function(){
  $(".screenshot_input").live('change', function(e){
    var self = $(this)
       ,file = e.target.files[0];
    
    var objectURL = getObjectURL(file);
    if(objectURL!=null)
    {
      //self.parent().append('<div class="crop_preview"><img class="cropped_image" src="'+objectURL+'"/></div>');
      // use jQmodal and add the ^ to that div, crop and display only cropped version
      $('.cropwrap').html('<img class="cropbox" src="'+objectURL+'"/>');

      crop_id = self.parent().prevAll().length;
      $('.cropbox').Jcrop({
          minSize: [ 938, 455 ],
          maxSize: [ 938, 455 ],
          setSelect: [0, 0, 938, 455],
          onSelect: function(coords) {
              $(".screenshot_input").eq(crop_id).parent().find('#crop_x').val(coords.x);
              $(".screenshot_input").eq(crop_id).parent().find('#crop_y').val(coords.y);
              $(".screenshot_input").eq(crop_id).parent().find('#crop_w').val(coords.w);
              $(".screenshot_input").eq(crop_id).parent().find('#crop_h').val(coords.h);
          }
      });
      //self.parent().find('.cropbox').jqmShow();
    }
  });

  $('.source_url').change(function(e) {
    var pattern = /^(http(s)?:\/\/github\.com\/).+(\/).+(\.git)$/
       ,repo_url = $(this).val();
    
    if(pattern.test(repo_url))
    {
      var repoString = repo_url.replace(/^http(s)?:\/\/github\.com\//i, "").replace(/\.git$/i, "");
      console.log(repoString);
      setRepoInfo(repoString);
    }
  });

  function setRepoInfo(repoString) {
    $.get('/projects/github_info/'+repoString+'.json'
          ,data = {}
          ,success = function(data, textStatus, xhr) {
            if(data['repository']!=undefined)
            {
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
    if((typeof window.URL!=="undefined") && (typeof window.URL.createObjectURL=="function"))
    {
      //Firefox 3.6+ and Opera
      return window.URL.createObjectURL(obj);
    }
    else if((typeof window.webkitURL != "undefined") && (typeof window.webkitURL.createObjectURL=="function"))  //Chrome 10+
    {
      return window.webkitURL.createObjectURL(obj);
    }
    return null;
  }

});

