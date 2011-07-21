class Screenshot < ActiveRecord::Base

  belongs_to :project

  has_attached_file :image,
                    :styles=>{:large => "938x455"},
                    :url => "/store/:attachment/:id/:style/:basename.:extension",  
                    :path => ":rails_root/permanent/store/:attachment/:id/:style/:basename.:extension",
                    :processors => [:cropper] 

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_save :reprocess_image, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank?
  end

  private
  
  def reprocess_image
    image.reprocess!
  end
end
