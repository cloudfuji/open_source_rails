class ProjectsController < ApplicationController

  before_filter :authenticate_user!, :only=>[:new, :create]

  def index
    @featured_project = FeaturedProject.includes(:project=>[:project_category]).
                                        first.project

    @projects = Project.includes(:project_category).
                        where("id != ? AND approved = ?", @featured_project, true)
  end

  def new
    @project = Project.new
    @project.build_author
    5.times do
      @project.screenshots.build
    end
  end

  def show
    @project = Project.includes(:project_category, :screenshots, :author).
                       find(params[:id])

    @similar_projects = ProjectCategory.limit(6).includes(:projects=>[:project_category]).
                                        find(@project.project_category_id).
                                        projects

    unless @project.approved?
      redirect_to root_path, :notice=>"That project doesn't exist"
    end
  end

  def create
    @project = Project.new(params[:project])
    
    @project.user_id = current_user.id
    if @project.save
      redirect_to @project
    else
      render :new
    end
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
