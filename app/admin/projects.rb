ActiveAdmin.register Project do
  index do
    column "Name" do |p|
      link_to p.title, admin_project_path(p)
    end
    
    column "Status", :sortable=>:approved do |p|
      return "Approved" if p.approved
      "Not approved"
    end

    column "Git url" do |p|
      p.source_url
    end
  end

  form do |f|
    f.buttons
    f.inputs "Details" do
      f.input :title
      f.input :approved
      f.input :short_desc
      f.input :about
      f.input :thumbnail
    end

    f.inputs  do
      f.has_many :authors do |a|
        if !a.object.id.nil?
          a.input :_destroy, :as=>:boolean, :label=>"delete"
        end
        a.inputs :name, :url
      end
    end
  
    f.inputs do
      f.has_many :screenshots do |s|
        unless s.object.id.nil?
          s.input :_destroy, :as=>:boolean, :label=>"delete"
          s.form_buffers.last << "<image src='#{s.object.image.url(:large)}'/>"
        else
          s.input :image
        end
      end
    end

    f.inputs :homepage_url, :source_url, :license
    f.buttons
  end

  show do
    div do 
      "Title: " + project.title
    end

    div do
      if project.approved?
        "Approved"
      else
        "Not approved"
      end
    end

    div do
      "Short description: " + project.short_desc
    end

    div do 
      "About: " + project.about
    end

    div do
      "License: " + project.license
    end
    
    div do
      raw("Homepage: " + link_to(project.homepage_url, project.homepage_url))
    end
    
    div do
      "Source: "+ project.source_url
    end

    div do
      hr
      h2 do
        "Authors"
      end
      project.authors.each do |a|
        div do
          a.name + ", " + a.url
        end
      end
    end

    div do
      hr
      h2 do
        "Thumbnail"
      end
      div do
        image_tag project.thumbnail.url(:large)
      end
    end

    div do
      hr
      h2 do
        "Screenshots"
      end
      project.screenshots.each do |s|
        div do
          image_tag s.image.url(:large)
        end
      end
    end
  end
end
