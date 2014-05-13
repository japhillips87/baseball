require 'spec_helper'

describe StatsController do
  describe '#most_improved_batting_average' do
    let(:player) { FactoryGirl.build :player }

    before { Player.stub(:most_improved_batting_average).and_return({player: player, improved_average: 0.35}) }

    it 'assigns the correct player' do
      get 'most_improved_batting_average'
      assigns(:player).should eq(player)
    end

    it 'assigns the correct average' do
      get 'most_improved_batting_average'
      assigns(:improved_average).should eq(0.35)
    end
  end
end
