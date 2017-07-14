class Resource < ApplicationRecord

  include HasSlug

  default_scope { order(resource_type: :asc) }

  allowed_types = %w[recording page blog download link]

  validates :title, :resource_type, presence: true
  validates :resource_type,
            inclusion: allowed_types,
            message: "Type '%<value>' is not a valid resource type"

  def to_s
    title
  end

end
