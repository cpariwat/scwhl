class AddOriginalPostsToSadCats < ActiveRecord::Migration[5.0]
  def change
    change_table :sad_cats do |t|
      t.belongs_to :original_tumblr, class_name: "OriginalPost"
      t.belongs_to :original_tweet, class_name: "OriginalPost"
    end
  end
end
