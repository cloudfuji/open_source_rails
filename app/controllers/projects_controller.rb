class ProjectsController < ApplicationController

  before_filter :authenticate_user!, :only=>[:new, :create]

  def index
    begin
      @featured_project = FeaturedProject.includes(:project=>[:project_category]).
                                        first.project                           

      @projects = Project.includes(:project_category).
                        where("id != ? AND approved = ?", @featured_project, true)
    rescue Exception => e
      puts "No projects #{e}"
    end
    
  end


  def external
      @featured_project = FeaturedProject.includes(:project=>[:project_category]).
                                        first.project                           

      @projects = Project.includes(:project_category).
                        where("id != ? AND approved = ?", @featured_project, true)

    render :layout => 'external'

  end


  def new
    @project = Project.new
    @project.build_author
    6.times do
    @project.screenshots.build
    end
  end

  def show
    begin
    @project = Project.includes(:project_category, :screenshots, :author).
                       find_by_slug(params[:id])
   
    if @project.not_approved?
        raise ActionController::RoutingError.new('Not Found')
    end

    @similar_projects = Project.includes(:project_category).
                                where("approved = ? AND project_category_id = ? AND ID != ?",
                                       true,
                                       @project.project_category_id,
                                       @project.id)
    rescue Exception => e
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def create
    @project = Project.new(params[:project])
    
    @project.user_id = current_user.id
    if @project.save
      redirect_to root_path, :notice => "Thank you for your submission!"
    else
      @screenshot_count = @project.screenshots.count
      if @screenshot_count!=6
        (6-@screenshot_count).times {@project.screenshots.build}
      end

      render :new
    end
  end
  
  def icon
    @project = Project.find_by_source_url(params[:repo])

    #image/png
    if @project.nil? or params[:repo].nil?
      response.headers['Content-Type'] = 'image/png'
      image_path = "#{Rails::root.to_s}/public/images/generic.png"
    else
      response.headers['Content-Type'] = @project.thumbnail_content_type
      image_path = @project.thumbnail.path
    end
    response.headers['Content-Disposition'] = 'inline'
    render :text => open(image_path, "rb").read
  end

  def github_info
    base_url = 'https://github.com/api/v2/json/repos/show/'

    unless params[:user].nil? or params[:repo].nil?
      result = Nestful.get(base_url+params[:user]+"/"+params[:repo])
      respond_to do |format|
        format.json do
          render :json => JSON.parse(result)
        end
      end
    end
  end

end
