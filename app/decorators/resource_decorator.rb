class ResourceDecorator < Draper::Decorator
  delegate_all
  decorates_association :grouping
  decorates_association :resource_parent

  def banner
    {
      "title" => object.title,
      "pretitle" => pretitle,
      "image" => lead_image,
      "biblereference" => reference_string,
      "description" => object.introduction,
      "subtitle" => subtitle,
    }
  end

  def pretitle
    if object.groupings.length.positive?
      object.groupings.first.title
    end
  end

  def subtitle
    object.introduction if object.resource_type == 'blog' && object.introduction
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
