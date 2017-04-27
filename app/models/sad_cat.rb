class SadCat < ApplicationRecord
  self.per_page = 5

  belongs_to :original_tumblr, class_name: "OriginalPost"
  belongs_to :original_tweet, class_name: "OriginalPost"
end
