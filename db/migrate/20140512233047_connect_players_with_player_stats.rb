class ConnectPlayersWithPlayerStats < ActiveRecord::Migration
  def up
    Player.all.each do |player|
      player.player_stats = PlayerStat.where(pid: player.pid).all.to_a
      player.save!
    end
  end

  def down
    Player.all.each do |player|
      player.player_stats = []
      player.save!
    end
  end
end
