class TumblrCatGrabberService
  def call
    client = Tumblr::Client.new

    cat_blog = client.posts("unimpressedcats.tumblr.com", type: "photo", limit: 20, offset: rand(1000))
    chosen_cat_post = cat_blog['posts']
                      .reject {|post| post['photos'].first['original_size']['url'].include?('.gif') }
                      .sample

    chosen_cat_post
  end
end