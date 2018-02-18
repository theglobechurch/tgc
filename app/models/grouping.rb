class Grouping < ApplicationRecord

  include HasSlug
  include HasState

  publishable

  default_scope { published.order('start_date DESC NULLS LAST') }

  # Create a scope for each of the grouping types (eg Grouping.preaching)
  gt = GroupingType.all.select("slug").map { |g| g.slug }
  gt.each do |g|
    scope g, lambda {
      eager_load(:grouping_types).
        where("grouping_types.slug": g)
    }
  end

  belongs_to :graphic,
             optional: true,
             foreign_key: :graphics_id

  has_many :resource_grouping_joins
  has_many :resources,
           through: :resource_grouping_joins

  has_many :group_type_links
  has_many :grouping_types,
           through: :group_type_links

  has_many :group_event_links
  has_many :events,
           through: :group_event_links

  validates :title, presence: true
  validates :grouping_types, presence: true

  def to_s
    title
  end

end
