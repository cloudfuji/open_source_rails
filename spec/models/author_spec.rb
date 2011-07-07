require 'spec_helper'

describe Author do
  describe "validations" do
    describe "name" do  
      it "presence" do
        should validate_presence_of(:name)
      end

      it "length" do
        should validate_length_of(:name, :minimum=>1, :maximum=>20)
      end
    end
  end

  describe "associations" do
    it "belongs to Project" do
      should belong_to(:project)
    end
  end
end
