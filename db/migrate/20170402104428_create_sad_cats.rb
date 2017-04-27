class CreateSadCats < ActiveRecord::Migration[5.0]
  def change
    create_table :sad_cats do |t|
      t.string :image, null: false
      t.integer :point, default: 0
      t.string :creator
      t.string :original_post
      t.string :original_tweet

      t.timestamps
    end
  end
end
