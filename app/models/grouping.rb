class Grouping < ApplicationRecord

  include HasSlug
  include HasState
  include HasGroupType

  publishable

  has_many :resource_grouping_joins
  has_many :resources,
           through: :resource_grouping_joins

  validates :title, :group_type, presence: true
  validates :group_type,
            inclusion: { in: GROUP_TYPES,
                         message: "%{value} is not a valid type" },
            allow_nil: false

  def to_s
    title
  end

end
