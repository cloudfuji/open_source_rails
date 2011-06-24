class Bookmark < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :user_id, :project_id

end
