class AddImageDataToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :landscape_image, :text
    add_column :projects, :thumb_image, :text
  end
end
