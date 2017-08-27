class Project < ApplicationRecord
	validates :name, presence: true, length: { maximum: 25 }
	validates :short_description, length: { maximum: 300, too_long: "Veuillez ne pas dépasser les %{count} caractères" }
	validates :collect_amount_goal, numericality: { only_integer: true, :greater_than_or_equal_to => 20 }, presence: true
	validates :status, inclusion: { in: ["brouillon", "en cours", "succés", "échec"] }

	belongs_to :category
	has_many :counterparts

	include LandscapeImageUploader::Attachment.new(:landscape)
	include PortraitImageUploader::Attachment.new(:portrait)

	#Permet de filtrer les projets publiés uniquement.
	scope :displayed, -> { where(status: ["en cours", "succés", "échec"]) }
	scope :running, -> {where(status: "en cours")}

end
