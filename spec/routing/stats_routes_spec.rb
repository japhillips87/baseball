require 'spec_helper'

describe StatsController do
  describe 'routing' do
    it 'routes / to #index' do
      get('/').should route_to('stats#index')
    end

    it 'routes /stats/most_improved_batting_average to #most_improved_batting_average' do
      get('/stats/most_improved_batting_average').should route_to('stats#most_improved_batting_average')
    end
  end
end

