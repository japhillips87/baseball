class Player < ActiveRecord::Base
  attr_accessible :birth_year, :first_name, :last_name, :pid
end
