class SadCatsController < ApplicationController
  before_filter :sanitize_params, only: [:create]

  def index
  end

  def new
    unimpressed_cat_post = TumblrCatGrabberService.new.call
    sad_tweet = TwitterSadGrabberService.new.call
    sad_picture_of_cat = SadCatProcessorService.new(cat_picture(unimpressed_cat_post), sad_tweet.text).call

    @sad_cat = SadCat.new(
        image: {
            path: sad_picture_of_cat,
        }.merge(cat_dimension(unimpressed_cat_post))
    )

    @original_tumblr = original_tumblr_attr(unimpressed_cat_post)
    @original_tweet = original_tweet_attr(sad_tweet)
  end

  def create
    SadCat.transaction do
      original_tweet = OriginalPost.find_or_create_by(original_tweet_params)
      original_tumblr = OriginalPost.find_or_create_by(original_tumblr_params)

      @sad_cat = SadCat.new(
          sad_cat_params.merge(
              original_tweet: original_tweet,
              original_tumblr: original_tumblr
          )
      )

      if @sad_cat.save!
        respond_to do |format|
          format.html { redirect_to sad_cats_path, notice: 'Great.. You brought a new sad cat into the world.' }
        end
      else
        render alert: 'Oh rats! something went wrong with server (hopefully not rats though).',
               status: :unprocessable_entity
      end
    end
  end

  def list_cats
    @sad_cats = SadCat.page(params[:page]).order('created_at DESC')

    render partial: 'sad_cats/partials/sad_cats_cards'
  end

  private

  def sad_cat_params
    params
        .require(:sad_cat)
        .permit(:creator,
                image: [:path, :width, :height]
        )
  end

  def original_tumblr_params
    params
        .require(:original_tumblr)
        .permit(original_tumblr_attr({}).keys)
  end

  def original_tweet_params
    params
        .require(:original_tweet)
        .permit(original_tweet_attr(Twitter::Tweet.new(id: nil)).keys)
  end

  def cat_picture(post)
    post['photos'].first['alt_sizes'].second['url']
  end

  def cat_dimension(post)
    {
        width: post['photos'].first['alt_sizes'].second['width'],
        height: post['photos'].first['alt_sizes'].second['height']
    }
  end

  def original_tumblr_attr(post)
    {
        account_name: post['blog_name'],
        url: post['short_url'],
        external_id: post['id'],
        post_type: OriginalPost.post_types[:tumblr]
    }
  end

  def original_tweet_attr(tweet)
    {
        account_name: tweet.user['screen_name'],
        url: tweet.url.to_s,
        external_id: tweet.id,
        post_type: OriginalPost.post_types[:tweet]
    }
  end

  def sanitize_params
    params['original_tweet']['external_id'] =  params['original_tweet']['external_id'].to_i
    params['original_tweet']['post_type'] =  params['original_tweet']['post_type'].to_i
    params['original_tumblr']['external_id'] =  params['original_tumblr']['external_id'].to_i
    params['original_tumblr']['post_type'] =  params['original_tumblr']['post_type'].to_i
  end
end
