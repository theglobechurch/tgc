class EventInstanceDecorator < Draper::Decorator
  delegate_all

  def address
    if object.location.present?
      object.location
    elsif object.event.location.present?
      object.event.location
    end
  end

  def address_html_formatted
    [address.name,
     address.address_line_1,
     address.address_line_2,
     address.city,
     address.code].reject(&:blank?).join('<br />')
  end

end
