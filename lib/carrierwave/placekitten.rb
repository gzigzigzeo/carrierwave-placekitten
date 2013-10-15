require 'active_support/concern'
require 'active_support/core_ext/module/attribute_accessors'
require 'carrierwave/placekitten/version'

module CarrierWave
  module PlaceKitten
    extend ActiveSupport::Concern
    include ActiveSupport::Configurable

    mattr_accessor :enabled, :kitten_url, :should_replace, :environments

    self.enabled = false
    self.kitten_url = "http://placekitten.com/g/%{width}/%{height}"
    self.environments = []
    self.should_replace = ->(image) {
      image.file.blank? || (image.file.present? && not(image.file.exists?))
    }

    module ClassMethods
      def placekitten(width, height, *args)
        private
        define_method :url_with_kitten_url do |*args|
          should_place =
            instance_exec(self, &should_replace) &&
            (not(defined?(Rails)) || Rails.env.in?(environments))

          if should_place
            kitten_url % { width: width, height: height }
          else
            url_without_kitten_url(*args)
          end
        end

        alias_method_chain :url, :kitten_url
      end
    end
  end
end
