module CarrierWave
  module PlaceKitten
    module Reflect
      class << self
        def size(version, *args)
          processors = version.processors.dup
          processors.delete_if { |p| not(PROCESSORS.include?(p.first)) }
          width, height = if processors.present?
            processors.last[1].first(2)
          end

          width  ||= args[0]
          height ||= args[1]

          [width, height]
        end
      end

      PROCESSORS = %i(
        resize_to_fill
        resize_to_fit
        resize_to_limit
        resize_and_pad
      )
    end
  end
end