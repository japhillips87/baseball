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

  def self.triple_crown_winners
    players = Player.includes(:player_stats).where('(player_stats.year_id = 2011 or player_stats.year_id = 2012) and player_stats.at_bat > 399')
    max_batting_avg_2011 = players.where('player_stats.year_id = 2011').map { |player| player.player_stats.first.batting_average }.max
    max_home_runs_2011 = players.where('player_stats.year_id = 2011').maximum(:home_runs)
    max_rbis_2011 = players.where('player_stats.year_id = 2011').maximum(:rbis)
    max_batting_avg_2012 = players.where('player_stats.year_id = 2012').map { |player| player.player_stats.first.batting_average }.max
    max_home_runs_2012 = players.where('player_stats.year_id = 2012').maximum(:home_runs)
    max_rbis_2012 = players.where('player_stats.year_id = 2012').maximum(:rbis)

    player_for_2011 = players.where('player_stats.home_runs' => max_home_runs_2011, 'player_stats.rbis' => max_rbis_2011).first
    player_for_2012 = players.where('player_stats.home_runs' => max_home_runs_2012, 'player_stats.rbis' => max_rbis_2012).first
    [
      { year: 2012, player: winner_or_nil_from(player_for_2012, max_batting_avg_2012) },
      { year: 2011, player: winner_or_nil_from(player_for_2011, max_batting_avg_2011) }
    ]
  end

  private

  def self.winner_or_nil_from(player, max_batting_avg)
    if player && player.player_stats.first.batting_average == max_batting_avg
      player
    else
      nil
    end
  end

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
