class ProjectCategory < ActiveRecord::Base

  has_many :projects  #don't add dependent destroy

end
