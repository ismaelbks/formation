class CreateCounterparts < ActiveRecord::Migration[5.1]
  def change
    create_table :counterparts do |t|
    	t.string :name
    	t.integer :amount
    	t.integer :number
    	t.text :description
    	t.text :portrait_data

      t.timestamps
    end
  end
end
