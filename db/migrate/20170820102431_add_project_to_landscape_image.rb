class AddProjectToLandscapeImage < ActiveRecord::Migration[5.1]
  def change
    add_reference :landscape_images, :project, index: true
    add_foreign_key :landscape_images, :project
  end
end
