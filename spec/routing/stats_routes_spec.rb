require 'spec_helper'

describe StatsController do
  describe 'routing' do
    it 'routes / to #index' do
      get('/').should route_to('stats#index')
    end

    it 'routes /stats/most_improved_batting_average to #most_improved_batting_average' do
      get('/stats/most_improved_batting_average').should route_to('stats#most_improved_batting_average')
    end

    it 'routes /stats/slugging_percentage to #slugging_percentage' do
      get('/stats/slugging_percentage').should route_to('stats#slugging_percentage')
    end

    it 'routes /stats/triple_crown_winners to #triple_crown_winners' do
      get('/stats/triple_crown_winners').should route_to('stats#triple_crown_winners')
    end
  end
end

