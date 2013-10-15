require 'active_support/concern'
require 'active_support/core_ext/module/attribute_accessors'
require 'carrierwave/placekitten/version'
require 'carrierwave/placekitten/reflect'

module CarrierWave
  module PlaceKitten
    extend ActiveSupport::Concern
    include ActiveSupport::Configurable

    mattr_accessor :enabled, :kitten_url, :should_replace

    self.enabled = false
    self.kitten_url = "http://placekitten.com/g/%{width}/%{height}"
    self.should_replace = ->(image) {
      image.file.blank? || (image.file.present? && not(image.file.exists?))
    }

    module ClassMethods
      def placekitten(*defaults)
        unless self.instance_methods.include?(:url_with_kitten_url)
          private
          define_method :url_with_kitten_url do |*args|
            if enabled
              # NOTE: A piece of code from CW
              version = if (version = args.first) && version.respond_to?(:to_sym)
                raise ArgumentError, "Version #{version} doesn't exist!" if versions[version.to_sym].nil?
                versions[version.to_sym] if version_exists?(version)
              end

              version ||= self

              should_place =
                instance_exec(version, &should_replace)

              width, height =
                CarrierWave::PlaceKitten::Reflect.size(version, *defaults)

              if should_place && not(width.nil? || height.nil?)
                kitten_url % { width: width, height: height }
              else
                url_without_kitten_url(*args)
              end
            else
              url_without_kitten_url(*args)
            end
          end

          alias_method_chain :url, :kitten_url
        end
      end
    end
  end
end
