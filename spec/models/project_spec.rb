require 'spec_helper'

describe Project do

  describe "validates" do
    describe "title" do
      it "presence of title" do
        should validate_presence_of(:title)
      end

      it "length of title" do
        should validate_length_of(:title, :minimum=>1, :maximum=>100)
      end
    end

    describe "short description" do
      it "presence" do
        should validate_presence_of(:short_desc)
      end

      it "length" do
        should validate_length_of(:short_desc, :minimum=>10)
      end
    end

    describe "source_url" do
      it "presence" do
        should validate_presence_of(:source_url)
      end
    
      it "valid value"  do
        should allow_values_for(:source_url, "https://github.com/bushido/opensourcerails.git")
      end

      it "invalid value" do
        should_not allow_values_for(:source_url, "git://gitsomething.com/project.git")
      end
    end
  end

  describe "associations" do
    it "has one author" do
      should have_one(:author).dependent(:destroy)
    end

    it "has many screenshots" do
      should have_many(:screenshots).dependent(:destroy)
    end
  end

  describe "nested attributes" do
    it "authors" do
      should accept_nested_attributes_for(:author, :allow_destroy=>true)
    end

    it "screenshots" do
      should accept_nested_attributes_for(:screenshots, :allow_destroy=>true)
    end
  end

  describe "custom methods" do
    it "project#not_approved? should return true if the project is not approved" do
      project = Fabricate(:project)
      project.not_approved?.should be_true
    end

    it "project#approve! should approve the project" do
      project = Fabricate(:project)
      project.approve!
      project.approved?.should be_true
    end

    it "project#unapprove! should unapprove the project" do
      project = Fabricate(:project)
      project.unapprove!
      project.approved?.should be_false
    end
  end
end
