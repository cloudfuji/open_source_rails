class Screenshot < ActiveRecord::Base

  belongs_to :project

  has_attached_file :image,
                    :styles=>{:large => "920x400"},
                    :url => "/store/:attachment/:id/:style/:basename.:extension",  
                    :path => ":rails_root/permanent/store/:attachment/:id/:style/:basename.:extension"
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
end
