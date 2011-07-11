class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.integer :project_id

      t.timestamps
    end
  end
end
