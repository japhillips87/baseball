class StatsController < ApplicationController
  def most_improved_batting_average
    @player, @improved_average = Player.most_improved_batting_average.values
  end
end
