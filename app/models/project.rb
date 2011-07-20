class Project < ActiveRecord::Base

  belongs_to :user
  belongs_to :project_category
  has_one :author, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
 
  has_attached_file :thumbnail,
                    :styles=>{:medium=>"100x100", :large=>"150x150"},
                    :url => "/store/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/permanent/store/:attachment/:id/:style/:basename.:extension",
                    :processors => [:cropper]

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

  accepts_nested_attributes_for :author, :allow_destroy=>true
  accepts_nested_attributes_for :screenshots, :allow_destroy=>true,
                                :reject_if => proc { |attrs| attrs['image'].blank? }

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

end
