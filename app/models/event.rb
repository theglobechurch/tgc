class Event < ApplicationRecord

  include HasSlug
  include HasState
  include HasUrlField
  include HasEventFlag

  url_field :link_url
  
  publishable
  
  default_scope { published }
  
  has_many :event_instances, dependent: :destroy
  accepts_nested_attributes_for :event_instances, allow_destroy: true, reject_if: proc { |att| att['start_datetime'].blank? }

  has_many :group_event_links
  has_many :groupings,
           through: :group_event_links
  
  belongs_to :location,
             optional: true

  belongs_to :graphic,
             optional: true,
             foreign_key: :graphics_id

  validates :title, :presence => true

  def to_s
    title
  end

end
