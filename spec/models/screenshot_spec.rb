require 'spec_helper'

describe Screenshot do

  describe "associations" do
    it "belongs to project" do
      should belong_to(:project)
    end
  end

end
