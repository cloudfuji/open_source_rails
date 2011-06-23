class Project < ActiveRecord::Base

  has_many :authors, :dependent => :destroy
  acts_as_taggable

  validates :title,
            :presence => true,
            :length => {:within => 1..100}
  
  validates :short_desc,
            :presence => true,
            :length => {:minimum => 10}

  validates_presence_of :source_url
   
end
