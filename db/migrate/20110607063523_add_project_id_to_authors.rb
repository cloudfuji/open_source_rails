class AddProjectIdToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :project_id, :integer
  end
end
