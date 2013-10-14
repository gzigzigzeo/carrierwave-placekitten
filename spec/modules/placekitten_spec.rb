require 'spec_helper'

describe CarrierWave::PlaceKitten do
  it 'must do' do
    uploader = TestUploader.new
    uploader.store!(File.open('Gemfile'))
    puts uploader.url
  end
end