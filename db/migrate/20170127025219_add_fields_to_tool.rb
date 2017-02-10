class AddFieldsToTool < ActiveRecord::Migration[5.0]
  def change
    add_column :tools, :latitude, :float
    add_column :tools, :longitude, :float
  end
end
