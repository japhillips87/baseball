class CreatePlayerStats < ActiveRecord::Migration
  def change
    create_table :player_stats do |t|
      t.string :pid
      t.integer :year_id
      t.string :league
      t.string :team_id
      t.integer :games
      t.integer :at_bat
      t.integer :runs
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :rbis
      t.integer :stolen_bases
      t.integer :caught_stealing

      t.timestamps
    end
  end
end
