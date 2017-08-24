class Category < ApplicationRecord
	validates :title, presence: true, length: { maximum: 25 }
	include ImageUploader::Attachment.new(:image)
	has_many :projects

end
