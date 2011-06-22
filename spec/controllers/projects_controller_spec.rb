require 'spec_helper'

describe ProjectsController do

  describe "GET 'index'" do
    it "assigns all projects as @projects" do
      #TODO should change when paginating project list
       
      get :index
      assigns(:projects).should eq([project])
    end
  end

  describe "GET 'edit'" do
    it "assigns the requested project as @project" do
      
      get 'edit', :id => 
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
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
