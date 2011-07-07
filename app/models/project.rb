class Project < ActiveRecord::Base

  has_many :authors, :dependent => :destroy
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

  accepts_nested_attributes_for :authors, :allow_destroy=>true

  # returns true if the project has been approved
  def approved?
    self.approved
  end

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
