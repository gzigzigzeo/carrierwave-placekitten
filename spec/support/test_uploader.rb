class TestUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::PlaceKitten

  def store_dir
    "store"
  end

  def cache_dir
    "cache"
  end

  placekitten 100, 200
  version :version do
    process resize_to_fill: [300, 400]
    version :next do
      process resize_to_fit: [500, 600]
    end
  end
end