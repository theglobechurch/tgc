class RecordingSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :name, :date, :slug, :description,
             :image, :passage, :url, :author,
             :audio, :series

  def name
    object.title
  end

  def date
    object.display_date
  end

  def slug
    object.slug
  end

  def passage
    object.reference_string
  end

  def audio
    base_url + object.upload.file.remote_url
  end

  def description
    object.introduction
  end

  def series
    {
      title: object.groupings[0].title,
      description: object.groupings[0].description,
      slug: object.groupings[0].slug,
      start_dt: object.groupings[0].start_date,
      end_dt: object.groupings[0].end_date,
      graphic: base_url + object.groupings[0].graphic.background_image.remote_url
    }
  end

  def url
    base_url + resource_path(object)
  end

  def base_url
    "https://www.globe.church"
  end

  def author
    {
      name: object.person.display_name,
      biography: object.person.biography_short,
      slug: object.person.slug,
      img: base_url + object.person.avatar_original.remote_url
    }
  end

  def image
    base_url + object.lead_image[:'2560']
  end
end
