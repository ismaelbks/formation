class Project < ApplicationRecord
	validates :name, presence: true, length: { maximum: 25 }
	validates :short_description, length: { maximum: 300, too_long: "Veuillez ne pas dépasser les %{count} caractères" }
	validates :collect_amount_goal, numericality: { only_integer: true, :greater_than_or_equal_to => 20 }, presence: true

	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
	after_update :crop_landscape



	include LandscapeImageUploader::Attachment.new(:landscape)
	include PortraitImageUploader::Attachment.new(:portrait)


	#belongs_to :user

	#Permet de filtrer les projets publiés uniquement.
	scope :displayed, -> { where(display: true) }

  

  	def crop_landscape
    	landscape.recreate_versions! if crop_x.present?
  	end

end
