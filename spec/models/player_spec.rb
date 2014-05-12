require 'spec_helper'

describe Player do
  it { should allow_mass_assignment_of(:birth_year) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:pid) }

  it { should have_many(:player_stats) }
end
