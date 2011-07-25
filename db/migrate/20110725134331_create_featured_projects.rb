class CreateFeaturedProjects < ActiveRecord::Migration
  def change
    create_table :featured_projects do |t|
      t.integer :project_id

      t.timestamps
    end
  end
end
