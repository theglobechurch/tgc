class Resource < ApplicationRecord

  include HasSlug           # Validate slug and allow lookup by slug rather than id
  include HasState          # Allow draft, published, deleted
  include HasResourceType   # Shares a list of resource types

  publishable

  default_scope { non_deleted.order(resource_type: :asc) }

  belongs_to :upload,
             optional: true,
             foreign_key: :uploads_id

  belongs_to :graphic,
             optional: true,
             foreign_key: :graphics_id

  has_many :resource_grouping_joins
  has_many :groupings,
           through: :resource_grouping_joins 

  validates :title, :resource_type, presence: true
  validates :resource_type,
            inclusion: { in: RESOURCE_TYPES,
                         message: "%{value} is not a valid type" },
            allow_nil: true

  def to_s
    title
  end

end
