require 'spec_helper'

describe '/stats/slugging_percentage' do
  let(:player1) { FactoryGirl.build(:player, first_name: 'Josh', last_name: 'Phillips') }
  let(:player2) { FactoryGirl.build(:player, first_name: 'Chuck', last_name: 'Norris') }
  let(:players) do
    [
      { player: player1, slugging_percentage: 0.5 },
      { player: player2, slugging_percentage: 0.45 }
    ]
  end

  before do
    assign(:players, players)
    render
  end

  specify { expect(rendered).to have_text('Josh Phillips') }
  specify { expect(rendered).to have_text('Chuck Norris') }
  specify { expect(rendered).to have_text('0.5') }
  specify { expect(rendered).to have_text('0.45') }
end
