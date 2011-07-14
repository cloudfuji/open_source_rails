require 'spec_helper'

describe ProjectsController do

  describe "GET 'index'" do
    it "assigns all projects as @projects" do
      project = Fabricate :project
      get :index
      assigns(:projects).should eq([project])
    end
  end

  describe "GET 'new'" do
    # TODO test if one author is being built
    it "creates a new project and assigns it to @project" do
      get :new
      assigns(:project).should be_a_new(Project)
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
    # TODO test if approved is false
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
    
    describe "with invalid params" do
      it "assigns to @project but unsaved" do
        Project.any_instance.stub(:save).and_return(false)
        post :create, :post=>{}
        assigns(:project).should be_a_new(Project)
      end

      it "should render the new action" do
        Project.any_instance.stub(:save).and_return(false)
        post :create, :post=>{}
        response.should render_template("new")
      end
    end
  end
  
end
