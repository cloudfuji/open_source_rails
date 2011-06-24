class Project < ActiveRecord::Base

  has_many :authors, :dependent => :destroy
  acts_as_taggable

  validates :title,
            :presence => true,
            :length => {:within => 1..100}
  
  validates :short_desc,
            :presence => true,
            :length => {:minimum => 10}

  validates :source_url,
            :presence => true,
            :format => { :with =>/\A(https:\/\/).+\.git\Z/i }
end
