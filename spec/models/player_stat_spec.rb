require 'spec_helper'

describe PlayerStat do
  it { should allow_mass_assignment_of(:at_bat) }
  it { should allow_mass_assignment_of(:caught_stealing) }
  it { should allow_mass_assignment_of(:doubles) }
  it { should allow_mass_assignment_of(:games) }
  it { should allow_mass_assignment_of(:hits) }
  it { should allow_mass_assignment_of(:home_runs) }
  it { should allow_mass_assignment_of(:league) }
  it { should allow_mass_assignment_of(:pid) }
  it { should allow_mass_assignment_of(:rbis) }
  it { should allow_mass_assignment_of(:runs) }
  it { should allow_mass_assignment_of(:stolen_bases) }
  it { should allow_mass_assignment_of(:team_id) }
  it { should allow_mass_assignment_of(:triples) }
  it { should allow_mass_assignment_of(:year_id) }

  describe '#batting_average' do
    let(:stat) { FactoryGirl.build(:player_stat, hits: 10, at_bat: 20) }
    let(:bad_stat) { FactoryGirl.build(:player_stat, hits: 0, at_bat: 0) }

    specify { expect(stat.batting_average).to eq 0.5 }
    specify { expect(bad_stat.batting_average).to eq 0 }
  end
end
