require 'spec_helper'

describe StatsController do
  describe '#most_improved_batting_average' do
    let(:player) { FactoryGirl.build(:player) }

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

  describe '#slugging_percentage' do
    let(:players) { FactoryGirl.build_list(:player, 2) }
    let(:player_slugging_hash) do
      [
        { 'player' => players.first, 'slugging_percentage' => 0.25 },
        { 'player' => players.last, 'slugging_percentage' => 0.35 }
      ]
    end

    before { Player.stub(:slugging_percentage).and_return(player_slugging_hash) }
    it 'assigns the correct players' do
      get 'slugging_percentage'
      assigns(:players).should eq(player_slugging_hash)
    end
  end
end
