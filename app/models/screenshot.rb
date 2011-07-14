class Screenshot < ActiveRecord::Base

  belongs_to :project

  has_attached_file :image, :styles=>{:full => "920x400"}

end
