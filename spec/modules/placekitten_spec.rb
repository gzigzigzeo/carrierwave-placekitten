require 'spec_helper'

describe CarrierWave::PlaceKitten do
  before { CarrierWave::PlaceKitten.enabled = true }

  context 'detached uploader' do
    subject { TestUploader.new.tap { |u| u.store!(File.open('Gemfile')) } }

    it('leaves existing file intact') {
      subject.url.should_not include('placekitten')
    }

    it('kittenizes missing file') {
      subject.remove!
      subject.url.should include('placekitten')
    }
  end
end