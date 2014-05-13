class PlayerStat < ActiveRecord::Base
  attr_accessible :at_bat, :caught_stealing, :doubles, :games, :hits, :home_runs, :league, :pid, :rbis, :runs, :stolen_bases, :team_id, :triples, :year_id

  def batting_average
    at_bat && at_bat > 0 ? hits / at_bat.to_f : 0
  end

  def slugging_percentage
    if at_bat && at_bat > 0
      ((hits - doubles - triples - home_runs) + (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bat.to_f
    else
      0
    end
  end
end
