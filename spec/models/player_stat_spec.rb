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
end
