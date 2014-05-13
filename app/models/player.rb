class Player < ActiveRecord::Base
  attr_accessible :birth_year, :first_name, :last_name, :pid

  has_many :player_stats

  def self.most_improved_batting_average
    where_sql = 'player_stats.at_bat > 199 and (player_stats.year_id = 2009 or player_stats.year_id = 2010)'
    players = Player.includes(:player_stats).where(where_sql)
    eligible_players = eligible_players_from(players)
    batting_average_hash = build_batting_average_hash_from(eligible_players)
    most_improved_avg = batting_average_hash.max_by { |k,v| v }
    { player: Player.find(most_improved_avg.first), improved_average: most_improved_avg.last }
  end

  def self.slugging_percentage
    players = Player.includes(:player_stats).where('player_stats.team_id = "OAK" and player_stats.year_id = 2007')
    build_slugging_percentage_hashes_from(players)
  end

  private

  def self.eligible_players_from(players)
    players.select do |player|
      (player.player_stats.map(&:year_id) & [2009,2010]).count == 2
    end
  end

  def self.build_batting_average_hash_from(eligible_players)
    batting_average_hash = {}
    eligible_players.each do |player|
      avg_for_2010 = player.player_stats.select { |stat| stat.year_id == 2010 }.first.batting_average
      avg_for_2009 = player.player_stats.select { |stat| stat.year_id == 2009 }.first.batting_average
      batting_average_hash[player.id] = avg_for_2010 - avg_for_2009
    end
    batting_average_hash
  end

  def self.build_slugging_percentage_hashes_from(players)
    slugging_array = []
    players.each do |player|
      slugging_array << { player: player, slugging_percentage: player.player_stats.first.slugging_percentage }
    end
    slugging_array
  end
end
