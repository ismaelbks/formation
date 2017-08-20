class LandscapeImage < ApplicationRecord
	#imageuploader for images
	include LandscapeImageUploader::Attachment.new(:image) # adds an `image` virtual attribute
	belongs_to :project
end
