require 'RMagick'
require 'open-uri'

class SadCatProcessorService < Struct.new(:image_url, :text)
  def call
    cats_pic = create_picture_of_sad_cat(image_url, text)
    cats_pic
  end

  private

  def create_picture_of_sad_cat(image_url, quote)
    canvas = Magick::ImageList.new
    urlimage = open(image_url)
    canvas.from_blob(urlimage.read)
    img = canvas.first

    overlay_text = Magick::Image.read("caption:#{quote}") do
      self.size = "#{canvas.columns}x100"
      self.font = "#{Rails.root}/lib/assets/GloriaHallelujah.ttf"
      self.fill = 'white'
      self.background_color = '#0008'
      self.gravity = Magick::CenterGravity
    end.first

    # img.quantize(256, Magick::GRAYColorspace)
    img.sepiatone
    canvas.average

    result = canvas.composite(overlay_text, Magick::SouthGravity, 0, 60, Magick::OverCompositeOp)
    path = "cat-#{SecureRandom.urlsafe_base64}.jpg"
    result.write("#{Rails.root}/app/assets/images/#{path}")

    path

  rescue Magick::ImageMagickError < e
    e.pretty_inspect
  end
end
