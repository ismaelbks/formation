class ImageUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :activerecord
  plugin :determine_mime_type
  plugin :logging, logger: Rails.logger
  plugin :remove_attachment
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :versions, names: [:original, :image]

  uploader = ImageUploader.new(:store)

  Attacher.validate do
    validate_max_size 3.megabytes, message: 'dépasse la taille limite (3 MB)'
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png']
  end

  def process(io, context)
    case context[:phase]
    when :store
      image = resize_to_limit!(io.download, 400, 300)
      { original: io, image: image }
    end
  end
end