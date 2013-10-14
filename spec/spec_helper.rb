$LOAD_PATH << "." unless $LOAD_PATH.include?(".")

require 'rubygems'
require 'bundler/setup'
require 'simplecov'
require 'carrierwave'

SimpleCov.start

require 'carrierwave/placekitten'
require 'support/test_uploader'

CarrierWave.root = File.expand_path(File.dirname(__FILE__))

CarrierWave.configure do |config|
  config.storage = :file
  #config.enable_processing = false
end

RSpec.configure do |config|
#  config.before do
#    FileUtils.rm_rf('tmp')
#  end
end

$: << File.join(File.dirname(__FILE__), '..', 'lib')