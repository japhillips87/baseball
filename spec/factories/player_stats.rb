FactoryGirl.define do
  factory :player_stat do
    pid 'someid'
    year_id 1987
    league 'NL'
    team_id 'ATL'
    games 1
    at_bat 2
    runs 3
    hits 4
    doubles 5
    triples 6
    home_runs 7
    rbis 8
    stolen_bases 9
    caught_stealing 10
  end
end
