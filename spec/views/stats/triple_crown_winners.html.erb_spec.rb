require 'spec_helper'

describe '/stats/triple_crown_winners' do
  let(:player1) { FactoryGirl.build(:player, first_name: 'Josh', last_name: 'Phillips') }
  let(:players) do
    [
      { year: 2012, player: player1 },
      { year: 2011, player: nil }
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
end
