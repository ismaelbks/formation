class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
    	t.string :name
    	t.text :short_description
    	t.text :long_description
    	t.integer :collect_amount_goal
    	t.boolean :display, :default => false
      t.timestamps
    end
  end
end
