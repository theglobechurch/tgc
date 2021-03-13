class SeriesSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :title, :description, :group_type, :start_date,
             :end_date, :slug, :image

  def title
    object.title
  end

  def description
    object.description
  end

  def group_type
    object.group_type
  end

  def start_date
    object.start_date
  end

  def end_date
    object.end_date
  end

  def slug
    object.slug
  end

  def base_url
    "https://www.globe.church"
  end

  def image
    if object.graphic.present?
      base_url + object.graphic.background_image.remote_url
    end
  end
end
