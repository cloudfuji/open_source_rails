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

    it "presence of source url" do
      should validate_presence_of(:source_url)
    end
  end
end
