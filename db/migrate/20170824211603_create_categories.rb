class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
    	t.string :title
    	t.string :description
    	t.text :image_data

      t.timestamps
    end
  end
end
