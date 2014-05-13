require 'spec_helper'

describe StatsController do
  describe 'routing' do
    it 'routes / to #index' do
      get('/').should route_to('stats#index')
    end
  end
end

