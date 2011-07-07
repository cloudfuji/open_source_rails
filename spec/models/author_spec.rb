require 'spec_helper'

describe Author do
  describe "validations" do
    describe "name" do  
      it "presence" do
        should validate_presence_of :name
      end

      it "length" do
        should ensure_length_of(:name).is_at_least(1).is_at_most(20)
      end
    end
  end

  describe "associations" do
    it "belongs to Project" do
      should_belong_to(:project)
    end
  end
end
