class Resource < ApplicationRecord

  include HasSlug   # Validate slug and allow lookup by slug rather than id
  include HasState  # Allow draft, published, deleted

  publishable

  default_scope { order(resource_type: :asc) }

  allowed_types = %w[recording page blog download link]

  validates :title, :resource_type, presence: true
  validates :resource_type,
            inclusion: { in: allowed_types ,
                         message: "Type '%<value>' is not a valid resource type" },
            allow_nil: true

  def to_s
    title
  end

end
