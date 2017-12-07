class One21Serializer < ActiveModel::Serializer
  attributes :name, :date, :slug, :description,
             :image, :passage, :url, :questions

  def name
    object.resource_parent.title
  end

  def date
    object.resource_parent.display_date
  end

  def slug
    object.resource_parent.slug
  end

  def passage
    object.resource_parent.reference_string
  end

  def description
    object.resource_parent.introduction
  end

  def url
    "http://globe.church#{view_context.resource_path(object.resource_parent)}"
  end

  def image
    object.lead_image
  end

  def questions
    object.body.map do |q|
      if q.type == :question
        {
          type: 'question',
          lead: q.coreQuestion,
          followup: q.subQuestions,
        }
      else
        {
          type: 'pause',
          body: q.text,
        }
      end
    end
  end
end
