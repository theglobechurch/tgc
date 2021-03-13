require 'digest'

module ApplicationHelper

  def markdown(text)
    MarkdownRenderer.new.to_markdown(text)
  end

  def svg_tag(icon, html_options = {})
    content_tag(
      :svg,
      content_tag(
        :use,
        '',
        'xlink:href': image_path("tgc-fractal.svg##{icon}"),
      ),
      html_options
    )
  end

  def gravatar_url(email, **options)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    URI("https://www.gravatar.com/avatar/" << hash).tap do |uri|
      uri.query = options.to_query
    end.to_s
  end

  def responsive_image_tag(graphic, html_options = {})
    if graphic.values[0].blank?
      return nil
    end

    srcset = graphic.map { |(k, v)| "https://globe.church#{URI.escape(v)} #{k}w" }
    kwargs = html_options.deep_merge(sizes:
      html_options.fetch(:sizes, []).join(', '))
    fallback = !graphic.try(:[], :"960").blank? ? "https://globe.church#{graphic.try(:[], :"960")}" : nil
    fallback = "https://globe.church#{graphic.values[0]}" if fallback.nil?
    image_tag URI.escape(fallback),
              srcset: srcset.join(', '),
              **kwargs
  end

end
