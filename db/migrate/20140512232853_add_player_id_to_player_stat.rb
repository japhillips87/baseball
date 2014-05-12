class AddPlayerIdToPlayerStat < ActiveRecord::Migration
  def change
    add_column :player_stats, :player_id, :integer
  end
end
