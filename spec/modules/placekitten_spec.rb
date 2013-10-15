require 'spec_helper'

describe CarrierWave::PlaceKitten do
  before { CarrierWave::PlaceKitten.enabled = true }
  let(:sample_file) { File.open('spec/fixtures/test.png') }

  context 'detached uploader' do
    subject { TestUploader.new.tap { |u| u.store!(sample_file) } }

    it('leaves existing file intact') {
      subject.url.should_not include('placekitten')
      subject.url(:version).should_not include('placekitten')
      subject.version.next.url.should_not include('placekitten')
    }

    it('kittenizes missing file') {
      subject.remove!
      subject.url.should include('placekitten')
      subject.url(:version).should include('placekitten')
      subject.version.next.url.should include('placekitten')
    }

    it('saves correct sizes for a file') {
      subject.remove!
      subject.url.should include('100/200')
      subject.url(:version).should include('300/400')
      subject.version.next.url.should include('500/600')
    }
  end
end