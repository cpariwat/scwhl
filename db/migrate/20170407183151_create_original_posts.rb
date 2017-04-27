class CreateOriginalPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :original_posts do |t|
      t.string :url
      t.string :account_name
      t.string :account_address
      t.integer :external_id, limit: 8, unique: true
      t.integer :post_type

      t.timestamps
    end
  end
end
