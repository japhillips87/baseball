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
    al_max_batting_avg_2011 = players.where('player_stats.year_id = 2011 and league = "AL"').map { |player| player.player_stats.first.batting_average }.max
    al_max_home_runs_2011 = players.where('player_stats.year_id = 2011 and league = "AL"').maximum(:home_runs)
    al_max_rbis_2011 = players.where('player_stats.year_id = 2011 and league = "AL"').maximum(:rbis)
    nl_max_batting_avg_2011 = players.where('player_stats.year_id = 2011 and league = "NL"').map { |player| player.player_stats.first.batting_average }.max
    nl_max_home_runs_2011 = players.where('player_stats.year_id = 2011 and league = "NL"').maximum(:home_runs)
    nl_max_rbis_2011 = players.where('player_stats.year_id = 2011 and league = "NL"').maximum(:rbis)
    al_max_batting_avg_2012 = players.where('player_stats.year_id = 2012 and league = "AL"').map { |player| player.player_stats.first.batting_average }.max
    al_max_home_runs_2012 = players.where('player_stats.year_id = 2012 and league = "AL"').maximum(:home_runs)
    al_max_rbis_2012 = players.where('player_stats.year_id = 2012 and league = "AL"').maximum(:rbis)
    nl_max_batting_avg_2012 = players.where('player_stats.year_id = 2012 and league = "NL"').map { |player| player.player_stats.first.batting_average }.max
    nl_max_home_runs_2012 = players.where('player_stats.year_id = 2012 and league = "NL"').maximum(:home_runs)
    nl_max_rbis_2012 = players.where('player_stats.year_id = 2012 and league = "NL"').maximum(:rbis)

    al_player_for_2011 = players.where('player_stats.home_runs' => al_max_home_runs_2011, 'player_stats.rbis' => al_max_rbis_2011, 'player_stats.league' => 'AL').first
    al_player_for_2012 = players.where('player_stats.home_runs' => al_max_home_runs_2012, 'player_stats.rbis' => al_max_rbis_2012, 'player_stats.league' => 'AL').first
    nl_player_for_2011 = players.where('player_stats.home_runs' => nl_max_home_runs_2011, 'player_stats.rbis' => nl_max_rbis_2011, 'player_stats.league' => 'NL').first
    nl_player_for_2012 = players.where('player_stats.home_runs' => nl_max_home_runs_2012, 'player_stats.rbis' => nl_max_rbis_2012, 'player_stats.league' => 'NL').first
    [
      { year: 2012, league: 'AL', player: winner_or_nil_from(al_player_for_2012, al_max_batting_avg_2012) },
      { year: 2012, league: 'NL', player: winner_or_nil_from(nl_player_for_2012, nl_max_batting_avg_2012) },
      { year: 2011, league: 'AL', player: winner_or_nil_from(al_player_for_2011, al_max_batting_avg_2011) },
      { year: 2011, league: 'NL', player: winner_or_nil_from(nl_player_for_2011, nl_max_batting_avg_2011) }
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
