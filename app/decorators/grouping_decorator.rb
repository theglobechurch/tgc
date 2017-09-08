class GroupingDecorator < Draper::Decorator
  delegate_all

  def banner
    {
      "title" => object.title,
      "image" => lead_image,
    }
  end

  def lead_image
    # unless object.graphic.nil?
    object&.graphic&.background_image_size_urls
    # end
  end

  def date_range
    if object.start_date && object.end_date
      if object.start_date.year == object.end_date.year
        "#{object.start_date.strftime('%B')} – "\
        "#{object.end_date.strftime('%B %Y')}"
      else
        "#{object.start_date.strftime('%B %Y')} – "\
        "#{object.end_date.strftime('%B %Y')}"
      end
    end
  end

end
