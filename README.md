# Carrierwave::PlaceKitten

There is a common case when images can not be transferred from production server
to local develoment environment. In this instance markup could look
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

  def store_dir
    "store"
  end

  def cache_dir
    "cache"
  end

  version :version do
    process resize_to_fill: [300, 400] # Detects size automatically
    version :next do
      process resize_to_fit: [500, 600]
    end
  end

  # IMPORTANT! You must include placekitten at the and of your uploader
  # to make it able to intercept calls to #url
  include CarrierWave::PlaceKitten
  placekitten 100, 200 # Default placeholder size
end
```

To make this work place somewhere your initializer:

```ruby
CarrierWave::PlaceKitten.enabled = true if Rails.env.development?
```

You also could specify:
```ruby
CarrierWave::PlaceKitten.url = 'http://example.com/%{width}x%{height}.jpg'
CarrierWave::PlaceKitten.should_replace = ->(image) {
  Rails.env.development? # Replace even existing files on development
}
```

Gem tries to automatically detect required image size by analyzing processing
chain. Known meta methods are: #resize_to_fill, #resize_to_fit, #resize_to_limits, #resize_and_pad.
Default size is used if none of known processing instructions found.

## TODO

1. Override defaults per version.
2. Override should replace per uploader.
3. Make able to include in base uploader/any part of file (with
black meta magick)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
