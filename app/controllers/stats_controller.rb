class StatsController < ApplicationController
  def most_improved_batting_average
    @player = Player.most_improved_batting_average
  end
end
