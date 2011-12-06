ActiveAdmin.register Project do

  before_filter :only => [:show, :edit, :update] do
    @project = Project.find_by_slug(params[:id])
  end
  
  index do
    column "Name" do |p|
      link_to p.title, admin_project_path(p.id)
    end

    column "Slug" do |p|
      unless p.slug.nil?
        p.slug
      else
        "--nil--"
      end
    end

    column "Status", :sortable=>:approved do |p|
      if p.approved?
        "Approved"
      else
        "Not approved"
      end
    end

    column "Category" do |p|
      unless p.project_category.nil?
        p.project_category.name
      else
        "--nil--"
      end
    end

    column "Tags" do |p|
      p.tag_list.join ", "
    end
  end

  form do |f|
    f.buttons
    f.inputs "Details" do
      f.input :title
      f.input :slug
      f.input :approved
      f.input :project_category_id, :as=>:select, :collection => ProjectCategory.find(:all, :order=>"name ASC")
      f.input :tag_list
      f.input :short_desc
      f.input :about
      f.input :thumbnail
    end

    f.semantic_fields_for :author do |author_form|
      author_form.inputs :name, :url
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
      unless project.slug.nil?
        "Slug: " + project.slug
      else
        "Slub: --nil--"
      end
    end

    div do
      if project.approved?
        "Approved"
      else
        "Not approved"
      end
    end

    div do
      unless project.project_category.nil? 
        "Category: " + project.project_category.name
      else
        "Category: --nil--"
      end
    end

    div do
      "Tags: " + project.tag_list.join(", ")
    end

    div do
      "Short description: " + project.short_desc
    end

    div do 
      "About: " + project.about
    end

    div do
      ("License: " + project.license) unless project.license.nil?
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
        "Author"
      end
      div do
        unless project.author.nil?
          project.author.name + ", " + project.author.url
        else
          "--nil-- [ENTER ONE SOON]"
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
