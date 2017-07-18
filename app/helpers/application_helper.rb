require 'digest'

module ApplicationHelper

  def svg_tag(icon, html_options = {})
    content_tag(
      :svg,
      content_tag(
        :use,
        '',
        'xlink:href': image_path("svg-symbols.svg##{icon}"),
      ),
      html_options)
  end

  def gravatar_url(email, **options)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    URI("http://www.gravatar.com/avatar/" << hash).tap do |uri|
      uri.query = options.to_query
    end.to_s
  end

end
