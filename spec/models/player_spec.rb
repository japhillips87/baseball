require 'spec_helper'

describe Player do
  it { should allow_mass_assignment_of(:birth_year) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:pid) }

  it { should have_many(:player_stats) }

  describe '.most_improved_batting_average' do
    let(:player_with_only_2009_stats) { FactoryGirl.create(:player, first_name: 'Bob') }
    let(:player_with_only_2010_stats) { FactoryGirl.create(:player, first_name: 'Bill') }
    let(:most_improved_player) { FactoryGirl.create(:player, first_name: 'Josh') }
    let(:player_with_too_few_at_bat) { FactoryGirl.create(:player, first_name: 'Kevin') }
    let(:least_improved_player) { FactoryGirl.create(:player, first_name: 'Steve') }

    before do
      player_with_only_2009_stats.player_stats << FactoryGirl.create(:player_stat, at_bat: 200, hits: 200, year_id: 2009)

      player_with_only_2010_stats.player_stats << FactoryGirl.create(:player_stat, at_bat: 200, hits: 200, year_id: 2010)

      most_improved_player.player_stats << FactoryGirl.create(:player_stat, at_bat: 200, hits: 50, year_id: 2009)
      most_improved_player.player_stats << FactoryGirl.create(:player_stat, at_bat: 200, hits: 100, year_id: 2010)

      player_with_too_few_at_bat.player_stats << FactoryGirl.create(:player_stat, at_bat: 199, hits: 1, year_id: 2009)
      player_with_too_few_at_bat.player_stats << FactoryGirl.create(:player_stat, at_bat: 199, hits: 185, year_id: 2010)

      player_with_too_few_at_bat.player_stats << FactoryGirl.create(:player_stat, at_bat: 200, hits: 150, year_id: 2009)
      player_with_too_few_at_bat.player_stats << FactoryGirl.create(:player_stat, at_bat: 200, hits: 1, year_id: 2010)
    end

    specify { expect(Player.most_improved_batting_average[:player]).to eq(most_improved_player) }
    specify { expect(Player.most_improved_batting_average[:improved_average]).to eq(0.25) }
  end

  describe '.slugging_percentage' do
    let(:player_oak_2009) { FactoryGirl.create(:player) }
    let(:player_oak_2007) { FactoryGirl.create(:player) }
    let(:player_atl_2007) { FactoryGirl.create(:player) }

    before do
      player_oak_2009.player_stats << FactoryGirl.create(:player_stat, team_id: 'OAK', year_id: 2009)
      player_oak_2007.player_stats << FactoryGirl.create(:player_stat, team_id: 'OAK', year_id: 2007, hits: 25, doubles: 4, triples: 2, home_runs: 12, at_bat: 50)
      player_atl_2007.player_stats << FactoryGirl.create(:player_stat, team_id: 'ATL', year_id: 2007)
    end

    specify { expect(Player.slugging_percentage.first[:player]).to eq(player_oak_2007) }
    specify { expect(Player.slugging_percentage.first[:slugging_percentage]).to eq(1.38) }
  end

  describe '.triple_crown_winners' do
    let(:player_with_low_rbis) { FactoryGirl.create(:player) }
    let(:player_with_high_rbis) { FactoryGirl.create(:player) }
    let(:triple_crown_winner) { FactoryGirl.create(:player) }
    let(:player_with_low_at_bat) { FactoryGirl.create(:player) }

    before do
      player_with_low_rbis.player_stats << FactoryGirl.create(:player_stat, hits: 350, at_bat: 400, home_runs: 100, rbis: 2, year_id: 2011)
      player_with_high_rbis.player_stats << FactoryGirl.create(:player_stat, hits: 340, at_bat: 400, home_runs: 10, rbis: 200, year_id: 2011)
      triple_crown_winner.player_stats << FactoryGirl.create(:player_stat, hits: 390, at_bat: 400, home_runs: 150, rbis: 200, year_id: 2012)
      player_with_low_at_bat.player_stats << FactoryGirl.create(:player_stat, hits: 100, at_bat: 200, home_runs: 100, rbis: 50, year_id: 2012)
    end

    specify { expect(Player.triple_crown_winners.first[:player]).to eq(triple_crown_winner) }
    specify { expect(Player.triple_crown_winners.last[:player]).to eq(nil) }
    specify { expect(Player.triple_crown_winners.first[:year]).to eq(2012) }
    specify { expect(Player.triple_crown_winners.last[:year]).to eq(2011) }
  end
end
