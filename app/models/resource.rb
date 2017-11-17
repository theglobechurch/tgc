class Resource < ApplicationRecord

  include HasSlug           # Validate slug and lookup by slug rather than id
  include HasState          # Allow draft, published, deleted
  include HasResourceType   # Shares a list of resource types
  include HasBibleReference
  include PgSearch

  inc_bible_reference
  publishable

  default_scope { published.order(resource_type: :asc) }

  pg_search_scope :search,
                  against: [:title],
                  using: {
                    tsearch: {prefix: true},
                  }

  RESOURCE_TYPES.each do |g|
    scope g, -> { where(resource_type: g) }
  end

  belongs_to :upload,
             optional: true,
             foreign_key: :uploads_id

  belongs_to :person,
             optional: true,
             foreign_key: :people_id

  belongs_to :graphic,
             optional: true,
             foreign_key: :graphics_id

  belongs_to :resource_parent,
             class_name: "Resource",
             optional: true,
             foreign_key: :parent_resource_id

  has_many :resource_grouping_joins
  has_many :groupings,
           through: :resource_grouping_joins
  has_many :children,
           class_name: "Resource",
           foreign_key: :parent_resource_id

  validates :title, :resource_type, presence: true
  validates :resource_type,
            inclusion: {
              in: RESOURCE_TYPES,
              message: "%{value} is not a valid type",
            },
            allow_nil: true

  sir_trevor_content :body

  def to_s
    title
  end

  def self.resource_type(rtype)
    where(resource_type: rtype)
  end

end
