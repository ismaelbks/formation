class Contribution < ApplicationRecord
	has_one :counterpart
	belongs_to :user
	belongs_to :project

end
