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

});

