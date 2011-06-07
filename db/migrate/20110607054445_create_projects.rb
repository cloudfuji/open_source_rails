class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :short_desc
      t.text :about
      t.string :license
      t.string :homepage_url
      t.string :source_url

      t.timestamps
    end
  end
end
