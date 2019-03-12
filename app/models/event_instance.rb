class EventInstance < ApplicationRecord

  # include HasSlug

  belongs_to :event, optional: true

  belongs_to :location,
              optional: true

  belongs_to :graphic,
             optional: true,
             foreign_key: :graphics_id

  validate :end_after_start
  validates :start_datetime, :end_datetime, :presence => true

  default_scope { order('start_datetime ASC NULLS LAST') }
  scope :future, -> { where("start_datetime >= ?", Time.now) }

  def to_s
    title
  end

private
  def end_after_start
    return if end_datetime.blank? || start_datetime.blank?
   
    if end_datetime < start_datetime
      errors.add(:end_datetime, "must be after the start date") 
    end 
   end
end
