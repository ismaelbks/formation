class AddProjectToCounterpart < ActiveRecord::Migration[5.1]
  def change
    add_reference :counterparts, :project, index: true
  end
end
