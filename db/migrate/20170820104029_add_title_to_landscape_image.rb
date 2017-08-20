class AddTitleToLandscapeImage < ActiveRecord::Migration[5.1]
  def change
    add_column :landscape_images, :title, :string
  end
end
