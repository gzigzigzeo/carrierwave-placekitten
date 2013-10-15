$LOAD_PATH << "." unless $LOAD_PATH.include?(".")

require 'rubygems'
require 'bundler/setup'
require 'simplecov'
require 'carrierwave'

SimpleCov.start

require 'carrierwave/placekitten'
require 'support/test_uploader'

CarrierWave.root = File.expand_path(File.join(File.dirname(__FILE__), '../tmp'))

CarrierWave.configure do |config|
  config.storage = :file
end

RSpec.configure do |config|
#  config.before do
#    FileUtils.rm_rf('tmp')
#  end
end

$: << File.join(File.dirname(__FILE__), '..', 'lib')