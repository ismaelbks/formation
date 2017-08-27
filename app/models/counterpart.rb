class Counterpart < ApplicationRecord
	belongs_to :project
	validates :amount, numericality: { only_integer: true, :greater_than_or_equal_to => 0 }, presence: true
	validates :name, presence: true, length: { maximum: 30 }
	validates :number, numericality: { only_integer: true, :greater_than => 0 }
	validates :stock, numericality: { only_integer: true, :greater_than_or_equal_to => 0 }


	include PortraitImageUploader::Attachment.new(:portrait)

end
