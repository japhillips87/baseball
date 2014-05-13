require 'spec_helper'

describe '/stats/most_improved_batting_average' do
  let(:player) { FactoryGirl.build(:player, first_name: 'Josh', last_name: 'Phillips') }

  before do
    assign(:player, player)
    assign(:improved_average, 0.35)
    render
  end

  specify { expect(rendered).to have_text('Josh Phillips') }
  specify { expect(rendered).to have_text('0.35') }
end
