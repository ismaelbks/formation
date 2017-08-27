class AddStockIllimiteToCounterpart < ActiveRecord::Migration[5.1]
  def change
    add_column :counterparts, :stock_illimite, :boolean, :default => false
  end
end
