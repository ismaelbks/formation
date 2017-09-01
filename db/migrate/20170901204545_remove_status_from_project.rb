class RemoveStatusFromProject < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :status, :string
    remove_column :projects, :display, :boolean

  end
end
