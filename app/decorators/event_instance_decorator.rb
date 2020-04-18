class EventInstanceDecorator < Draper::Decorator
  delegate_all

  def title
    "#{@event_instance.event.title}#{@event_instance.title != '' ? ": " + @event_instance.title : ""}"
  end

  def banner
    {
      "title" => object.title,
      "image" => lead_image,
    }
  end

  def lead_image
    if object.event.graphics_id
      object&.event&.graphic&.background_image_size_urls
    elsif object.graphics_id
      object&.graphic&.background_image_size_urls
    end
  end

  def address
    if object.location.present?
      object.location
    elsif object.event.location.present?
      object.event.location
    end
  end

  def external_link
    if object.link_url.present?
      return object.link_url
    elsif object.event.link_url.present?
      return object.event.link_url
    end
  end

  def address_fields
    [address.name,
     address.address_line_1,
     address.address_line_2,
     address.city,
     address.code].reject(&:blank?)
  end

end
