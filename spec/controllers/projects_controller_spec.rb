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

  describe "PUT 'update'" do
    describe "with valid params" do
      it "finds and assigns the project to @project" do
        project = Fabricate :project
        put :update, :id=>project.id, :project=>project.attributes
        assigns(:project).should eq(project)
      end

      it "should update attributes" do
        project = Fabricate :project
        Project.any_instance.should_receive(:update_attributes).with(project.attributes)
        put :update, :id=>project.id, :project=>project.attributes
      end

      it "redirects to the project page once updated" do
        project = Fabricate :project
        put :update, :id=>project.id, :project=>project.attributes
        response.should redirect_to(project)
      end
    end
  
    describe "with invalid params" do
      it "assigns project to @project" do
        project = Fabricate :project
        Project.any_instance.stub(:save).and_return(false)
        put :update, :id=>project.id, :project=>{}
        assigns(:project).should eq(project)
      end

      it "renders the 'edit' template" do
        project = Fabricate :project
        Project.any_instance.stub(:save).and_return(false)
        put :update, :id=>project.id, :project=>{}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroy the requested project" do
      project = Fabricate :project
      expect {
        delete :destroy, :id=>project.id
      }.to change(Project, :count).by(-1)
    end
    
    it "redirects to the list of projects once deleted" do
      project = Fabricate :project
      delete :destroy, :id => project.id
      response.should redirect_to(projects_url)
    end
  end


end
