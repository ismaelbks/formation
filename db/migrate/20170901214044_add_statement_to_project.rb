class AddStatementToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :statement, :string, :default => "Draft"
  end
end
