require 'oembed'

class VideoProvider

  def self.get(video_url)
    if video_url =~ /vimeo.com/
      OEmbed::Providers::Vimeo.get(video_url)
    elsif video_url =~ /(youtube.com)|(youtu.be)/
      OEmbed::Providers::Youtube.get(video_url)
    else
      raise URI::InvalidURIError.new
    end
  end

end
