class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @project.authors.build
    @project.screenshots.build
  end

  def show
    @project = Project.includes(:screenshots, :authors).find(params[:id])
    unless @project.approved?
      redirect_to root_path, :notice=>"That project doesn't exist"
    end
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

end
