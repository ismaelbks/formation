class AddStockToCounterpart < ActiveRecord::Migration[5.1]
  def change
    add_column :counterparts, :stock, :integer
  end
end
