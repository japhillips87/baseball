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
end
