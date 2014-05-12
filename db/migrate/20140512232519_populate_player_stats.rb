require 'csv'

class PopulatePlayerStats < ActiveRecord::Migration
  def up
    PlayerStat.delete_all
    CSV.foreach('player_stats.csv', :headers => true) do |row|
      PlayerStat.create!(row.to_hash)
    end
  end

  def down
    PlayerStat.delete_all
  end
end
