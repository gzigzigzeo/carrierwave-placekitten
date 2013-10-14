class TestUploader < CarrierWave::Uploader::Base
  include CarrierWave::PlaceKitten

  def store_dir
    "tmp/store"
  end

  def cache_dir
    "tmp/cache"
  end

  placekitten 100, 200
  version :version do
    placekitten 300, 400
    version :version do
      placekitten 500, 600
    end
  end
end