class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fill: [200, 200]
  end

  version :medium do
    process resize_to_fill: [600, 600]
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
