class Screenshot < ActiveRecord::Base

  belongs_to :project

  has_attached_file :image, :styles=>{:medium => "300x300>"}

end
