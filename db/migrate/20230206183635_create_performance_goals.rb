class CreatePerformanceGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :performance_goals do |t|
      t.string :title, null: false
      t.integer :value, null: false

      t.timestamps
    end
  end
end
