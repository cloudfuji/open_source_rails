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
      project.id
    end
    div do 
      project.title
    end
    div do
      project.approved
    end
    div do
      project.short_desc
    end
    div do
      project.license
    end
    div do
      project.homepage_url
    end
    div do
      project.source_url
    end
  end
end
