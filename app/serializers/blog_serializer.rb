class BlogSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :name, :date, :slug, :description,
             :image, :passage, :url, :author,
             :content

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

  def content
    object.body
  end

  def description
    object.introduction
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
      img: object.person.avatar_original_uid
    }
  end

  def image
    base_url + object.lead_image[:'2560']
  end
end
