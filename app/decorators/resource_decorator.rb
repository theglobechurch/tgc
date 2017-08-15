class ResourceDecorator < Draper::Decorator
  delegate_all

  def banner
    {
      "title" => title,
      "pretitle" => pretitle
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

end
