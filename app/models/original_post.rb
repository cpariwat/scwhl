class OriginalPost < ApplicationRecord
  enum post_type: %i(tweet tumblr)

  has_many :sad_cats
end
