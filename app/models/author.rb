class Author < ActiveRecord::Base
  
  belongs_to :project 
  
  validates :name,
            :presence => true,
            :length => { :within=>1..20 }

end
