require 'spec_helper'

describe ProjectsController do

  describe "GET 'index'" do
    it "assigns all projects as @projects" do
      #TODO should change when paginating project list
      # project = Project.make!   
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
      project = Project.make! 
      get 'edit', :id => project.id.to_s 
      assigns(:project).should eq(project)
    end
  end

  describe "GET 'show'" do
    it "assigns the requested project as @project" do
      project = Project.make!
      get :show, :id => project.id.to_s
      assigns(:project).should eq(project)
    end
  end

  describe "POST 'create'" do
    describe "with valid params" do
      it "creates a new project" do
        expect {
          post :create, :project => Project.make!.attributes
          assigns(:project).should eq(project)
        }.to change(Project, :count).by(1)
      end

      it "redirects to the created project" do
        post :create, :project => Project.make!.attributes
        response.should redirect_to(Project.last)
      end

      it "assigns a newly created project as @project" do
        post :create, :project => Project.make!
        assigns(:project).should be_a(Project) #we know this right?
        assigns(:project).should be_persisted
      end
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_success
    end
  end

end
