class ResourceDecorator < Draper::Decorator
  delegate_all

  def banner
    {
      "title" => title,
      "pretitle" => pretitle,
      "image" => lead_image
    }
  end

  def pretitle
    if !object.groupings.nil?
      object.groupings.first.title
    end
  end

  def title
    object.title
  end

  def lead_image
    if !object.graphic.nil?
      object.graphic.background_image_size_urls
    elsif !object.groupings.nil? && !object.groupings.graphics.nil?
      object.groupings.graphic.background_image_size_urls
    end
  end

end
