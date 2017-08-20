class LandscapeImageUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :activerecord
  plugin :determine_mime_type
  plugin :logging, logger: Rails.logger
  plugin :remove_attachment
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :versions, names: [:original, :landscape]

  uploader = LandscapeImageUploader.new(:store)

  Attacher.validate do
    validate_max_size 3.megabytes, message: 'dépasse la taille limite (3 MB)'
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png']
  end

  def process(io, context)
    case context[:phase]
    when :store
      landscape = resize_to_limit!(io.download, 700, 350)
      { original: io, landscape: landscape }
    end
  end
end