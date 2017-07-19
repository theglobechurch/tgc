class Resource < ApplicationRecord

  include HasSlug           # Validate slug and allow lookup by slug rather than id
  include HasState          # Allow draft, published, deleted
  include HasResourceType   # Shares a list of resource types

  publishable

  default_scope { non_deleted.order(resource_type: :asc) }

  belongs_to :upload,
             optional: true,
             foreign_key: :uploads_id

  validates :title, :resource_type, presence: true
  validates :resource_type,
            inclusion: { in: RESOURCE_TYPES,
                         message: "%{value} is not a valid type" },
            allow_nil: true

  def to_s
    title
  end

end
