require 'spec_helper'

describe Bookmark do

  describe "associations" do
    it "belongs to user" do
      should belong_to(:user)
    end
  end

  describe "validations" do
    it "presence of user_id" do
      should validate_presence_of(:user_id)
    end
    
    it "presence of project_id" do
      should validate_presence_of(:project_id)
    end
  end

end
