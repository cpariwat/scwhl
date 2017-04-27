require 'twitter'

class TwitterSadGrabberService
  def call
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV.fetch('twitter_consumer_key')
      config.consumer_secret =  ENV.fetch('twitter_consumer_secret')
      config.access_token = ENV.fetch('twitter_access_token')
      config.access_token_secret = ENV.fetch('twitter_access_token_secret')
    end

    # from:sosadtoday - the most uplifted account on twitter
    # filter:safe - sometimes cats can be vulgar
    # -rt -@ - non-rt only, no mention, no link, no images
    # random_date = (0..7).to_a.sample.days.ago.strftime('%Y-%m-%d')
    sad_tweets = twitter_client.search('from:sosadtoday -rt filter:safe -filter:links -filter:media')
    sad_text = sad_tweets.reject { |tweet| tweet.text.include? '@' }
                         .sample
    sad_text
  end
end
