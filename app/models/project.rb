class Project < ApplicationRecord
	validates :name, presence: true, length: { maximum: 25 }
	validates :short_description, length: { maximum: 300, too_long: "Veuillez ne pas dépasser les %{count} caractères" }
	validates :collect_amount_goal, numericality: { only_integer: true, :greater_than_or_equal_to => 20 }, presence: true

	#belongs_to :user

	#Permet de filtrer les projets publiés uniquement.
	scope :displayed, -> { where(display: true) }

	#imageuploader for images
	include LandscapeImageUploader::Attachment.new(:image) # adds an `image` virtual attribute

end
