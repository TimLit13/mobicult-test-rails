class CreatePlayerPerformances < ActiveRecord::Migration[7.0]
  def change
    create_table :player_performances do |t|
      t.belongs_to :player, foreign_key: true
      t.belongs_to :performance_goal, foreign_key: true
      t.belongs_to :match, foreign_key: true
      t.boolean :reached_performance, default: false

      t.timestamps
    end
  end
end
