class EventDecorator < Draper::Decorator
  delegate_all

  def banner
    {
      "title" => object.title,
      "image" => lead_image,
    }
  end

  def lead_image
    if object.graphics_id
      object&.graphic&.background_image_size_urls
    end
  end

end
