require 'spec_helper'

describe '/stats/index' do
  before { render }

  it 'has a link for the most improved batting average' do
    expect(rendered).to have_selector('a[href="/stats/most_improved_batting_average"]', text: 'Most Improved Batting Average (2009-2010)')
  end

  it 'has a link for the most slugging percentage' do
    expect(rendered).to have_selector('a[href="/stats/slugging_percentage"]', text: "Slugging Percentage (Oakland A's 2007)")
  end
end
