class Project < ActiveRecord::Base

  has_many :authors
  acts_as_taggable

end
