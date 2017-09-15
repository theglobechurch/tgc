class ResourceDecorator < Draper::Decorator
  delegate_all
  decorates_association :grouping

  def banner
    {
      "title" => object.title,
      "pretitle" => pretitle,
      "image" => lead_image,
      "biblereference" => reference_string,
      "description" => object.introduction,
    }
  end

  def pretitle
    if object.groupings.length.positive?
      object.groupings.first.title
    end
  end

  def lead_image
    if !object.graphic.nil?
      object.graphic.background_image_size_urls
    elsif object.groupings.length.positive? &&
          !object.groupings.first.graphic.nil?
      object.groupings.first.graphic.background_image_size_urls
    end
  end

end
