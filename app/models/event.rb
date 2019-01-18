class Event < ApplicationRecord

  include HasSlug
  include HasState
  
  publishable
  
  default_scope { published }
  
  has_many :event_instances, dependent: :destroy
  accepts_nested_attributes_for :event_instances, allow_destroy: true, reject_if: proc { |att| att['title'].blank? }

  has_many :group_event_links
  has_many :groupings,
           through: :group_event_links

  def to_s
    title
  end

end
