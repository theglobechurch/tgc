class Event < ApplicationRecord

  include HasSlug
  include HasState

  accepts_nested_attributes_for :event_instance

  publishable

  default_scope { published }

  has_many :event_instances

  has_many :group_event_links
  has_many :groupings,
           through: :group_event_links

  def to_s
    title
  end

end
