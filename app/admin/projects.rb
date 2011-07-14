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
      raw("Homepage: " + link_to(project.homepage_url, ("http://" + project.homepage_url)))
    end
    
    div do
      "Source: "+ project.source_url
    end

    div do
      hr
      h2 do
        "Authors"
      end
    end
    div do
      hr
      h2 do
        "Screenshots"
      end
    end
  end
end
