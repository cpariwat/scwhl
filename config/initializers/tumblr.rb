require 'tumblr_client'

Tumblr.configure do |config|
  config.consumer_key = ENV.fetch('tumblr_consumer_key')
  config.consumer_secret = ENV.fetch('tumblr_consumer_secret')
end