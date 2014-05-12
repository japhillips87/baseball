class Player < ActiveRecord::Base
  attr_accessible :birth_year, :first_name, :last_name, :pid

  has_many :player_stats
end
