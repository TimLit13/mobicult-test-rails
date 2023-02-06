class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :title, null: false

      t.timestamps
    end

    add_reference :players, :team, foreign_key: true
  end
end
