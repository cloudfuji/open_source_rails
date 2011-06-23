require 'spec_helper'

describe ProjectsController do

  describe "GET 'index'" do
  
    it "should be sucessfull" do
      get :index
      response.should be_successful
    end

    it "assigns all projects as @projects" do
      project = Project.new
      project.save
      get :index
      assigns(:projects).should eq([project])
    end
  end

  describe "GET 'new'" do
    it "creates a new project and assigns it to @project" do
      get :new
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "GET 'edit'" do
    it "assigns the requested project as @project" do
      project = Fabricate(:project)
      
      get 'edit', :id => project.id.to_s 
      assigns(:project).should eq(project)
    end
  end

  describe "GET 'show'" do
    it "assigns the requested project as @project" do
      project = Fabricate(:project)
      
      get :show, :id => project.id.to_s
      assigns(:project).should eq(project)
    end
  end

  describe "POST 'create'" do
    describe "with valid params" do
      it "creates a new project" do
        expect {
          post :create, :project => Fabricate.build(:project).attributes
        }.to change(Project, :count).by(1)
      end

      it "redirects to the created project" do
        post :create, :project => Fabricate.build(:project).attributes
        response.should redirect_to(Project.last)
      end

      it "assigns a newly created project as @project" do
        post :create, :project => Fabricate.build(:project).attributes
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end
    end
  end

end
