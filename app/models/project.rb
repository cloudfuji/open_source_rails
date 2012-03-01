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

  # # quick dev env compatibility
  # 
  # has_attached_file :thumbnail,
  #                   :styles=>{:medium=>"100x100", :large=>"150x150"},
  #                   :url => "/store/:attachment/:id/:style/:basename.:extension",
  #                   :path => ":rails_root/permanent/store/:attachment/:id/:style/:basename.:extension",
  #                   :processors => [:cropper]

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

  def to_param
    slug
  end

  # approved is a boolean field and approved? is made available by rails
  # returns true if the project is not approved
  def not_approved?
    !self.approved?
  end

  # approve a project in-place
  def approve!
    self.update_attribute :approved, true
  end

  # unapprove a project in-place
  def unapprove!
    self.update_attribute :approved, false
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank?
  end

  private

  def reprocess_thumbnail
    thumbnail.reprocess!
  end

  def generate_slug
    self.update_attribute(:slug, self.id) if not self.slug
  end
end
