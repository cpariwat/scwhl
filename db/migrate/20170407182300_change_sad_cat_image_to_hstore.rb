class ChangeSadCatImageToHstore < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'hstore'
    remove_column :sad_cats, :image, :string
    remove_column :sad_cats, :original_post, :string
    remove_column :sad_cats, :original_tweet, :string
    add_column :sad_cats, :image, :hstore
  end
end
