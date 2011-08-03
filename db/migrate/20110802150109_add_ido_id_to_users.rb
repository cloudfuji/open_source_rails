class AddIdoIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ido_id, :string
  end
end
