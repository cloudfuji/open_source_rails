class ExternalController < ApplicationController
  caches_page :external

  def index
    return redirect_to "/external/#{@project.id}" if @project = Project.find_by_title(params[:project])

      @featured_project = FeaturedProject.includes(:project=>[:project_category]).first.project                           

      @projects = Project.includes(:project_category).
                        where("id != ? AND approved = ?", @featured_project, true)

    render :layout => 'external'

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
    render :layout => 'external'
  end
  
  def proxy
    @proxy_path = params[:proxy_path]
    render :layout => false
  end


end
