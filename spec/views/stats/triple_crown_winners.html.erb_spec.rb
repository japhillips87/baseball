require 'spec_helper'

describe '/stats/triple_crown_winners' do
  let(:player1) { FactoryGirl.build(:player, first_name: 'Josh', last_name: 'Phillips') }
  let(:players) do
    [
      { year: 2012, league: 'AL', player: player1 },
      { year: 2012, league: 'NL', player: nil },
      { year: 2011, league: 'AL', player: nil },
      { year: 2011, league: 'NL', player: nil }
    ]
  end

  before do
    assign(:players, players)
    render
  end

  specify { expect(rendered).to have_text('Josh Phillips') }
  specify { expect(rendered).to have_text('No Winner') }
  specify { expect(rendered).to have_text('2012') }
  specify { expect(rendered).to have_text('2011') }
  specify { expect(rendered).to have_text('AL') }
  specify { expect(rendered).to have_text('NL') }
end
