# Carrierwave::Placekitten

There is a common case when images can not be transferred from production server
to local develoment environment. In this instance markup could display
corrupted because of image urls are nils.

This gem helps to replace physically missing images with http://placekitten.com
placeholders.

## Installation

Add this line to your application's Gemfile:

    gem 'carrierwave-placekitten'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave-placekitten

## Usage

```ruby
class FooUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::PlaceKitten

  def store_dir
    "store"
  end

  def cache_dir
    "cache"
  end

  placekitten 100, 200 # Default placeholder size
  version :version do
    process resize_to_fill: [300, 400] # Detects size automatically
    version :next do
      process resize_to_fit: [500, 600]
    end
  end
end
```

To make this work place somewhere your initializer:

```ruby
CarrierWave::PlaceKitten.enabled = true
CarrierWave::PlaceKitten.environments = [:development]
end

You also could specify:
```ruby
CarrierWave::PlaceKitten.url = 'http://example.com/%{width}x%{height}.jpg'
CarrierWave::PlaceKitten.should_replace = ->(image) {
  Rails.env.development? # Always replace on development
}
```

Gem tries to automatically detect required image size by analyzing processing
chain. Known meta methods are: #resize_to_fill, #resize_to_fit,
#resize_to_limits, #resize_and_pad. Default size is used if none of known
processing instructions found.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
