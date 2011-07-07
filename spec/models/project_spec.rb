require 'spec_helper'

describe Project do

  describe "validates" do
    it "presence of title" do
      should validate_presence_of(:title)
    end

    it "length of title" do
      should ensure_length_of(:title).is_at_least(1).is_at_most(100)
    end

    it "presense of short description" do
      should validate_presence_of(:short_desc)
    end

    it "length of short description" do
      should ensure_length_of(:short_desc).is_at_least(10)
    end

    describe "source_url" do
      it "presence" do
        should validate_presence_of(:source_url)
      end
    
      it "valid value"  do
        should validate_format_of(:source_url).with("https://github.com/bushido/opensourcerails.git")
      end

      it "invalid value" do
        should validate_format_of(:source_url).not_with("git://gitsomething.com/project.git")
      end
    end
  end

  # TODO: test accepts_nested_attributs_for :authors

  describe "associations" do
    it "has many authors" do
      should have_many(:authors).dependent(:destroy)
    end
  end

end
