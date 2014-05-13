class PlayerStat < ActiveRecord::Base
  attr_accessible :at_bat, :caught_stealing, :doubles, :games, :hits, :home_runs, :league, :pid, :rbis, :runs, :stolen_bases, :team_id, :triples, :year_id

  def batting_average
    at_bat > 0 ? hits.to_f / at_bat.to_f : 0
  end
end
