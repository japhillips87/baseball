class StatsController < ApplicationController
  def most_improved_batting_average
    @player, @improved_average = Player.most_improved_batting_average.values
  end

  def slugging_percentage
    @players = Player.slugging_percentage
  end

  def triple_crown_winners
    @players = Player.triple_crown_winners
  end
end
