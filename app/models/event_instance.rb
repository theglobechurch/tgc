class EventInstance < ApplicationRecord

  # include HasSlug
  include HasEventFlag
  include HasUrlField

  belongs_to :event, optional: true

  belongs_to :location,
              optional: true

  belongs_to :graphic,
             optional: true,
             foreign_key: :graphics_id

  validate :end_after_start
  validates :start_datetime, :end_datetime, :presence => true

  default_scope { order('start_datetime ASC NULLS LAST') }
  scope :future, -> { where("start_datetime >= ?", Time.now).order('start_datetime ASC NULLS LAST') }

  before_validation do |r|
    r.slug = r.title.parameterize if r.slug.blank? && !r.title.blank?
  end

  def to_s
    title
  end

  def instance_path
    if slug
      return "/events/#{event.slug}/#{slug}"
    else
      return "/events/#{event.slug}/#{start_datetime.strftime("%F")}"
    end
  end

  def siblings
    event.event_instances.where.not(id:self.id)
  end

private
  def end_after_start
    return if end_datetime.blank? || start_datetime.blank?
   
    if end_datetime < start_datetime
      errors.add(:end_datetime, "must be after the start date") 
    end 
   end
end
