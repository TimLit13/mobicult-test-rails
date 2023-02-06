class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.belongs_to :home_team, index: true, foreign_key: { to_table: :teams }
      t.belongs_to :away_team, index: true, foreign_key: { to_table: :teams }

      t.timestamps
    end
  end
end
