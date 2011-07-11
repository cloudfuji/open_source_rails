class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @project.authors.build
    @project.screenshots.build
  end

  def edit
    @project = Project.includes(:screenshots, :authors).find(params[:id])
  end

  def show
    @project = Project.includes(:screenshots, :authors).find(params[:id])
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url
  end

end
