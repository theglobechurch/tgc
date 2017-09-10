class Grouping < ApplicationRecord

  include HasSlug
  include HasState
  include HasGroupType

  publishable

  default_scope { published.order('start_date DESC NULLS LAST') }

  GROUP_TYPES.each do |g|
    scope g, -> { where(group_type: g) }
  end

  belongs_to :graphic,
             optional: true,
             foreign_key: :graphics_id

  has_many :resource_grouping_joins
  has_many :resources,
           through: :resource_grouping_joins

  validates :title, :group_type, presence: true
  validates :group_type,
            inclusion: {
              in: GROUP_TYPES,
              message: "%{value} is not a valid type",
            },
            allow_nil: false

  def to_s
    title
  end

end
