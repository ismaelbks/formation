class AddImagesToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :landscape_data, :text
    add_column :projects, :portrait_data, :text
  end
end
