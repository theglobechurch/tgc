class One21Serializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :name, :date, :slug, :description, :images,
             :image, :passage, :url, :questions, :base_url

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
    base_url + resource_path(object.resource_parent)
  end

  def base_url
    "https://www.globe.church"
  end

  def images
    object.lead_image.map do |k, str|
      [k, base_url + str]
    end.to_h
  end

  def image
    base_url + object.lead_image[:'960']
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
