class Project < ActiveRecord::Base

  has_many :authors, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
 
  has_attached_file :thumbnail,
                    :styles=>{:medium=>"100x100", :large=>"150x150"},
                    :url => "/store/:attachment/:id/:style/:basename.:extension",  
                    :path => ":rails_root/permanent/store/:attachment/:id/:style/:basename.:extension"

  validates :title,
            :presence => true,
            :length => {:within => 1..100}
  
  validates :short_desc,
            :presence => true,
            :length => {:minimum => 10}

  validates :source_url,
            :presence => true,
            :format => { :with =>/\A(https:\/\/).+\.git\Z/i }

  accepts_nested_attributes_for :authors, :allow_destroy=>true
  accepts_nested_attributes_for :screenshots, :allow_destroy=>true

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
