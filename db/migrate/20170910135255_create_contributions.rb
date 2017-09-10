class CreateContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :contributions do |t|
      t.decimal :amount
      t.belongs_to :project, index: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
