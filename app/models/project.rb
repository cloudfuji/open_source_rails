class Project < ActiveRecord::Base

  belongs_to :user
  belongs_to :project_category
  has_one :featured_project, :dependent=>:destroy
  has_one :author, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
 
  has_attached_file :thumbnail,
                    :storage        => :s3,
                    :s3_credentials => "config/s3.yml",
                    :styles         => { :medium => "100x100", :large => "150x150" },
                    :url            => "/:attachment/:id/:style/:basename.:extension",
                    :path           => "#{ENV['S3_PREFIX']}/:attachment/:id/:style/:basename.:extension",
                    :processors     => [:cropper]

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

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
  
  validates :homepage_url,
            :presence => true,
            :format => { :with =>/\A(http(s)?:\/\/).*/i }

  accepts_nested_attributes_for :author, :allow_destroy=>true
  accepts_nested_attributes_for :screenshots, :allow_destroy=>true,
                                :reject_if => proc { |attrs| attrs['image'].blank? }

  after_save :reprocess_thumbnail, :if => :cropping?
  after_save :generate_slug


  def generate_slug
    self.update_attribute(:slug, self.id) if not self.slug
  end

end
