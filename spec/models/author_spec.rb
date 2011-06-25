require 'spec_helper'

describe Author do
  describe "validations" do
    it "presence of name" do
      should validate_presence_of(:name)
    end

    it "length of name" do
      should ensure_length_of(:name).is_at_least(1).is_at_most(20)
    end
  end

  describe "associations" do
    it "belongs to Project" do
      should belong_to(:project)
    end
  end
end
