require 'csv'

class PopulatePlayers < ActiveRecord::Migration
  def up
    Player.delete_all
    CSV.foreach('players.csv', :headers => true) do |row|
      Player.create!(row.to_hash)
    end
  end

  def down
    Player.delete_all
  end
end
