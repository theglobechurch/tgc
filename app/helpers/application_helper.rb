require 'digest'

module ApplicationHelper

  def svg_tag(icon, html_options = {})
    content_tag(
      :svg,
      content_tag(
        :use,
        '',
        'xlink:href': image_path("tgc-fractal.svg##{icon}"),
      ),
      html_options)
  end

  def gravatar_url(email, **options)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    URI("http://www.gravatar.com/avatar/" << hash).tap do |uri|
      uri.query = options.to_query
    end.to_s
  end

  def responsive_image_tag(graphic, html_options = {})
    srcset = graphic.map { |(k, v)| "#{URI.escape(v)} #{k}w" }
    kwargs = html_options.deep_merge(sizes:
      html_options.fetch(:sizes, []).join(', '))
    image_tag URI.escape(graphic.try(:[], :"960")),
              srcset: srcset.join(', '),
              **kwargs
  end

end
