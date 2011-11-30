class Screenshot < ActiveRecord::Base

  belongs_to :project

  has_attached_file :image,
                    :processors     => [ :cropper ],
                    :s3_credentials => "config/s3.yml",
                    :styles         => { :large => "938x455" },
                    :url            => "/:attachment/:id/:style/:basename.:extension",  
                    :path           => "#{ENV['S3_PREFIX']}/:attachment/:id/:style/:basename.:extension"

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
