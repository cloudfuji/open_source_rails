require 'spec_helper'

describe User do
  describe "associations" do
    it "has many bookmarks" do
      should have_many(:bookmarks)
    end
  end
end
